# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/wterm/wterm-6.2.9-r2.ebuild,v 1.1 2003/01/13 11:13:57 raker Exp $

DESCRIPTION="A fork of rxvt patched for fast transparency and a NeXT scrollbar"
HOMEPAGE="http://largo.windowmaker.org/files.php#wterm"
SRC_URI="http://largo.windowmaker.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND="virtual/x11
	>=x11-wm/WindowMaker-0.80.1"

S="${WORKDIR}/${P}"

src_compile() {

	local myconf
	
	myconf="--enable-menubar --enable-graphics --with-term=rxvt \
		--enable-transparency --enable-next-scroll --enable-xpm-background"

	econf ${myconf} || die "configure failed"

	emake || die "parallel make failed"

}

src_install() {

	make DESTDIR=${D} install || die "make install failed"

	insinto /usr/share/pixmaps
	doins *.xpm *.tiff

}
