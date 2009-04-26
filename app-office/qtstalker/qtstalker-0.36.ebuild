# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/qtstalker/qtstalker-0.36.ebuild,v 1.1 2009/04/26 12:10:33 patrick Exp $

EAPI=1

inherit qt3 eutils multilib

LANGS="pl"
for i in ${LANGS}; do
	IUSE="${IUSE} linguas_${i}"
done

DESCRIPTION="Commodity and stock market charting and technical analysis"
HOMEPAGE="http://qtstalker.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="x11-libs/qt:3
	>=sci-libs/ta-lib-0.4.0
	>=sys-libs/db-4.3"

IUSE=""

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-nodocs.patch
	epatch "${FILESDIR}"/${P}-parallel-make.patch
	epatch "${FILESDIR}"/${P}-gcc43.patch

#blshkv
	epatch "${FILESDIR}"/${P}-fibo.patch
	epatch "${FILESDIR}"/${P}-csv_quote.patch

	ebegin 'Fixing install paths'
	grep -rl '/usr/local' * \
		| xargs sed -i -e "s:/usr/local:/usr:g"
	eend

	ebegin 'Fixing multilib paths'
	grep -rl '/usr/lib' * \
		| xargs sed -i -e "s:/usr/lib:/usr/$(get_libdir):g"
	eend

	ebegin 'Fixing manual paths'
	grep -rl '/usr/share/doc/qtstalker/' * \
		| xargs sed -i -e "s:/usr/share/doc/qtstalker/:/usr/share/doc/${PF}/:g"
	eend
}

src_compile() {
	eqmake3 || die "eqmake3 failed."
	emake || die "emake failed."

	for i in ${LINGUAS}; do
		if [[ -f ${PN}_${i}.ts ]]; then
			ebegin "Building langpacks..."
			lrelease ${PN}_${i}.ts
			eend
		fi
	done
}

src_install() {
	export INSTALL_ROOT="${D}"
	sed -i -e 's:-strip ::g' "${S}"/plugins/quote/*/Makefile
	emake install || die "emake install failed."

	ebegin "Installing docs"
	cd "${S}"/docs
	dohtml *{html,png}
	dodoc AUTHORS BUGS CHANGELOG-${PV} TODO "${S}"/README
	eend

	# install only needed langpacks
	ebegin "Installing langpacks"
	cd "${S}"/i18n
	insinto /usr/share/${PN}/i18n
	for i in ${LINGUAS}; do
		if [[ -f ${PN}_${i}.qm ]]; then
			doins ${PN}_${i}.qm
		fi
	done
	eend

	# menu and icon
	domenu "${FILESDIR}"/${PN}.desktop
	doicon "${FILESDIR}"/${PN}.png
}
