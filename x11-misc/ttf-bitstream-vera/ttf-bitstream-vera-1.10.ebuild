# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/ttf-bitstream-vera/ttf-bitstream-vera-1.10.ebuild,v 1.1 2003/04/17 16:49:35 foser Exp $

inherit gnome.org

DESCRIPTION="Bitstream Vera font family"
HOMEPAGE="http://www.gnome.org/fonts/"
LICENSE="BitstreamVera"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~arm"
IUSE=""

DEPEND=""

src_install() {
	insinto /usr/share/fonts/${PN}
	doins *.ttf

	dodoc COPYRIGHT.TXT README.TXT RELEASENOTES.TXT
}

pkg_postinst() {
	einfo "For optimal performance of this font we suggest updating to at least fontconfig-2.1.94 ."
}
