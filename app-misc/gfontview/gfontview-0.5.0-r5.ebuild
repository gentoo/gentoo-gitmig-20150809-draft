# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gfontview/gfontview-0.5.0-r5.ebuild,v 1.1 2003/06/16 16:54:17 lu_zero Exp $

DESCRIPTION="Fontviewer for PostScript Type 1 and TrueType"
SRC_URI="mirror://sourceforge/gfontview/${P}.tar.gz"
HOMEPAGE="http://gfontview.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE="nls gnome"

DEPEND=">=media-libs/t1lib-1.0.1
	=media-libs/freetype-1*
	=x11-libs/gtk+-1.2*
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )"
RDEPEND="nls? ( sys-devel/gettext )"

inherit eutils
##EPATCH_SOURCE="${FILESDIR}"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
        epatch ${FILESDIR}/01_all_gcc33.patch.bz2 
}

src_compile() {
	local myconf
	use nls || myconf="--disable-nls"
	econf ${myconf}
	make || die
}

src_install() {
	einstall
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
	insinto /usr/X11R6/include/X11/pixmaps/
	doins error.xpm openhand.xpm font.xpm t1.xpm tt.xpm 
}
