# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/qtstalker/qtstalker-0.33.ebuild,v 1.1 2007/03/05 22:59:48 troll Exp $

inherit qt3 eutils

IUSE=""
LANGS="pl"
for i in ${LNAGS}; do
	IUSE="${IUSE} linguas_${i}"
done

DESCRIPTION="Commodity and stock market charting and technical analysis"
HOMEPAGE="http://qtstalker.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="$(qt_min_version 3.3)
	>=sys-libs/db-4"

S="${WORKDIR}/${PN}"

# linking error about missing lqtstalker lib when using -jX
MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-sandboxfix_no_fixpath.patch
	epatch ${FILESDIR}/${P}-install_docs_with_emerge.patch
}

src_compile() {
	# some Qt4 problems...
	einfo "Proccessing qmake with .pro files..."
	PROS="${S}/src/src.pro ${S}/lib/lib.pro ${S}/${PN}.pro `find ${S}/plugins -name \"*.pro\"`"
	for i in ${PROS}; do
		pdir="`echo ${i} | sed -e 's/\/[a-zA-Z]*.pro$//'`"
		pfile="`echo ${i} | sed -e 's/^.*\///'`"

		cd ${pdir}
		${QTDIR}/bin/qmake ${pfile} \
			QMAKE_CXXFLAGS_RELEASE="${CXXFLAGS}" \
			QMAKE_RPATH= \
			QMAKE=/usr/bin/qmake \
			QMAKE_RPATH= \
			|| die "qmake ${pfile} failed"
	done

	cd ${S}
	emake || die "make failed"

	einfo "Building langpaccks..."
	for i in ${LINGUAS}; do
		if [ -f ${PN}_${i}.ts ]; then
			lrelease ${PN}_${i}.ts
		fi
	done
}

src_install() {
	# we have to export this...
	export INSTALL_ROOT="${D}"
	make install || die "make install failed"

	einfo "Installing docs..."
	cd ${S}/docs
	dohtml *{html,png}
	dodoc AUTHORS BUGS CHANGELOG INSTALL TODO ${S}/README

	# install only needed langpacks
	einfo "Installing langpacks..."
	cd ${S}/i18n
	insinto /usr/share/${PN}/i18n
	for i in ${LINGUAS}; do
		if [ -f ${PN}_${i}.qm ]; then
			doins ${PN}_${i}.qm
		fi
	done

	# menu and icon
	domenu ${FILESDIR}/${PN}.desktop
	doicon ${FILESDIR}/${PN}.png
}
