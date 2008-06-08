# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/pothana2k/pothana2k-2006-r1.ebuild,v 1.3 2008/06/08 21:39:18 ken69267 Exp $

inherit font

DESCRIPTION="Pothana 2000 and Vemana fonts for the Telugu script"
HOMEPAGE="http://www.kavya-nandanam.com/"
SRC_URI="mirror://gentoo/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="doc"

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}"
FONT_S="${WORKDIR}"
FONT_SUFFIX="ttf"

FONT_CONF=( "${FILESDIR}/65-pothana2k.conf" )

src_install() {
	font_src_install
	if use doc
	then
		dodoc MANUAL.PDF
	fi
}

pkg_postinst() {
	elog "To actually use this font for rendering Telugu, enable it in fontconfig:"
	elog "eselect fontconfig enable 65-pothana2k.conf"
}
