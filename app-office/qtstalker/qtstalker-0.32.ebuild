# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/qtstalker/qtstalker-0.32.ebuild,v 1.1 2006/09/28 21:29:29 troll Exp $

inherit qt3 eutils

IUSE="mysql"
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
	mysql? ( dev-db/mysql )"

S="${WORKDIR}/${PN}"

# linking erros about missing lqtstalker lib when -jX
# from MAKEOPTS is being set to anything higher than -j1
MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-sandboxfix_no_fixpath.patch
	epatch ${FILESDIR}/${PN}-install_docs_with_emerge.patch
	# without that, qtstalker will use mysql, when only it is installed,
	# even when we do not want mysql support for this package
	! use mysql && epatch ${FILESDIR}/${PN}-no_mysql_support.patch
}

src_compile() {
	${QTDIR}/bin/qmake ${PN}.pro \
		QMAKE_CXXFLAGS_RELEASE="${CXXFLAGS}" \
		QMAKE_RPATH= \
		|| die "qmake ${PN}.pro failed"

	cd ${S}/lib
	${QTDIR}/bin/qmake lib.pro \
		QMAKE_CXXFLAGS_RELEASE="${CXXFLAGS}" \
		QMAKE_RPATH= \
		|| die "qmake ${PN}.pro failed"

	cd ${S}
	emake || die "make failed"
}

src_install() {
	# we have to export this...
	export INSTALL_ROOT="${D}"
	make install || die "make install failed"

	cd ${S}/docs
	dohtml *{html,png}
	dodoc AUTHORS BUGS CHANGELOG INSTALL TODO ${S}/README

	# install only needed langpacks
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
