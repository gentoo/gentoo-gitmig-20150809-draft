# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/wterm/wterm-6.2.9-r2.ebuild,v 1.8 2004/03/28 02:39:57 mr_bones_ Exp $

DESCRIPTION="A fork of rxvt patched for fast transparency and a NeXT scrollbar"
HOMEPAGE="http://largo.windowmaker.org/files.php#wterm"
SRC_URI="http://largo.windowmaker.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="cjk"

DEPEND="virtual/x11
	>=x11-wm/windowmaker-0.80.1"

src_compile() {
	local myconf

	myconf="--enable-menubar --enable-graphics --with-term=rxvt \
		--enable-transparency --enable-next-scroll --enable-xpm-background"

	use cjk && myconf="$myconf --enable-kanji"

	econf ${myconf} || die "configure failed"
	emake || die "parallel make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	insinto /usr/share/pixmaps
	doins *.xpm *.tiff
}
