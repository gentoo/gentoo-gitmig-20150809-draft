# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/aterm/aterm-0.4.2-r4.ebuild,v 1.5 2003/03/27 14:18:42 nakano Exp $

IUSE="cjk"
S=${WORKDIR}/${P}
DESCRIPTION="A terminal emulator with transparency support as well as rxvt backwards compatibility"
SRC_URI="mirror://sourceforge/aterm/${P}.tar.bz2
	cjk? (http://wakaba.com/~tsann/aterm/aterm-0.4.2-ja.patch)"
HOMEPAGE="http://aterm.sourceforge.net"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="media-libs/jpeg
	media-libs/libpng
	virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}/src
	cp feature.h feature.h.orig
	sed "s:\(#define LINUX_KEYS\):/\*\1\*/:" \
		feature.h.orig > feature.h

	if [ "`use cjk`" ]; then
		cd ${S}
		patch -p1 < ${DISTDIR}/aterm-0.4.2-ja.patch
	fi

}

src_compile() {
	local myconf

	use cjk && myconf="$myconf --enable-kanji --enable-xim --enable-linespace"
echo $myconf

	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--host=${CHOST} \
		--enable-transparency \
		--enable-fading \
		--enable-background-image \
		--enable-menubar \
		--enable-graphics \
		--enable-utmp \
		--with-x \
		$myconf

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	fperms g+s /usr/bin/aterm
	fowners root.utmp /usr/bin/aterm

	dodoc TODO ChangeLog INSTALL doc/BUGS doc/FAQ doc/README.menu
	docinto menu
	dodoc doc/menu/*
	dohtml -r .
}
