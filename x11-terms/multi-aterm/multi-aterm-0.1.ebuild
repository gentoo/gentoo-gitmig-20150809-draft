# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/multi-aterm/multi-aterm-0.1.ebuild,v 1.7 2004/04/10 02:08:16 nakano Exp $

DESCRIPTION="A terminal emulator with transparency support as well as rxvt backwards compatibility like aterm, with tab support"
HOMEPAGE="http://www.nongnu.org/materm/materm.html"
SRC_URI="http://www.nongnu.org/materm/${P}.tar.gz"

IUSE="cjk"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc sparc ~alpha hppa"

DEPEND="media-libs/jpeg
	media-libs/libpng
	virtual/x11"

src_compile() {
	cd ${S}/src
	sed -i "s:\(#define LINUX_KEYS\):/\*\1\*/:" \
		feature.h

	local myconf
	use cjk && myconf="--enable-kanji"

	cd ${S}
	econf --enable-transparency \
		--enable-fading \
		--enable-xterm-scroll \
		--enable-half-shadow \
		--enable-graphics \
		--enable-mousewheel \
		--with-x $myconf || die
	emake || die
}

src_install () {
	einstall || die
}
