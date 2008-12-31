# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/kita/kita-1.90.4.ebuild,v 1.1 2008/12/31 17:05:36 matsuu Exp $

inherit eutils

SLOT="2"
MY_PN="${PN}${SLOT}"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Kita - 2ch client for KDE"
HOMEPAGE="http://kita.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/kita/33012/${MY_P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="kde-base/korundum
	kde-base/qtruby"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gems.patch"
}

src_install() {
	local mydir=/usr/share/${MY_PN}
	exeinto ${mydir}
	doexe *.rb
	insinto  ${mydir}
	doins *.kdevelop *.png *.ui

	newicon kita.png ${MY_PN}.png
	domenu "${FILESDIR}/${MY_PN}.desktop"

	dodoc README.ja
	make_wrapper ${MY_PN} ./kita.rb ${mydir}
}
