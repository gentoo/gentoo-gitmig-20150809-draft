# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/multi-aterm/multi-aterm-0.0.4.ebuild,v 1.4 2004/03/28 02:18:54 mr_bones_ Exp $

DESCRIPTION="A terminal emulator with transparency support as well as rxvt backwards compatibility like aterm, with tab support"
SRC_URI=" http://www.materm.tuxfamily.org/${P}.tar.gz"
HOMEPAGE="http://www.materm.tuxfamily.org/materm.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"

DEPEND="media-libs/jpeg
	media-libs/libpng
	virtual/x11"

src_compile() {
	cd ${S}/src
	sed -i "s:\(#define LINUX_KEYS\):/\*\1\*/:" \
		feature.h

	cd ${S}
	econf --enable-transparency \
		--enable-fading \
		--enable-xterm-scroll \
		--enable-half-shadow \
		--enable-graphics \
		--enable-mousewheel \
		--with-x
	emake || die
}

src_install () {
	einstall
}
