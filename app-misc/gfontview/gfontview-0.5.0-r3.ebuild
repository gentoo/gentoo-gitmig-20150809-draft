# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/gfontview/gfontview-0.5.0-r3.ebuild,v 1.2 2002/07/25 17:20:00 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Fontviewer for PostScript Type 1 and TrueType"
SRC_URI="http://download.sourceforge.net/gfontview/${P}.tar.gz"
HOMEPAGE="http://gfontview.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=media-libs/t1lib-1.0.1
	=media-libs/freetype-1*
	=x11-libs/gtk+-1.2*
	virtual/lpr
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )"

RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {

	local myconf
	use nls || myconf="--disable-nls"
	
	econf ${myconf} || die
	make || die
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
	insinto /usr/X11R6/include/X11/pixmaps/
	doins error.xpm openhand.xpm font.xpm t1.xpm tt.xpm 
}
