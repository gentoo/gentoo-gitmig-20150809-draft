# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xdvik/xdvik-22.40y-r1.ebuild,v 1.2 2003/09/05 22:37:22 msterret Exp $

inherit eutils

IUSE="cjk libwww"

XDVIK_JP="${P}-j1.17"

DESCRIPTION="DVI previewer for X Window System"
SRC_URI="mirror://sourceforge/xdvi/${P}.tar.gz
	cjk? ( mirror://gentoo/${XDVIK_JP}.patch.gz )"
HOMEPAGE="http://sourceforge.net/projects/xdvi/"

KEYWORDS="~x86 ~alpha ~ppc ~sparc"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-libs/t1lib-1.3
	virtual/tetex
	virtual/x11
	cjk? ( media-fonts/kochi-substitute )
	libwww? ( >=net-libs/libwww-5.3.2-r1 )"

src_unpack () {

	unpack ${P}.tar.gz
	if [ -n "`use cjk`" ] ; then
		epatch ${DISTDIR}/${XDVIK_JP}.patch.gz
		epatch ${FILESDIR}/${XDVIK_JP}-vfontcap-gentoo.diff
	fi
}

src_compile () {

	local myconf

	use libwww && myconf="--with-system-wwwlib"
	use cjk && myconf="${myconf} --with-vflib=vf2ft" \
		&& export CPPFLAGS="${CPPFLAGS} -I/usr/include/freetype2"

	econf --enable-xdvietcdir=/usr/share/texmf/xdvi \
		--disable-multiplatform \
		--with-system-t1lib \
		${myconf} || die "econf failed"

	cd texk/xdvik
	make || die
}

src_install () {

	dodir /usr/share/texmf/xdvi
	dodir /usr/share/man/man1

	cd ${S}/texk/xdvik
	einstall texmf=${D}/usr/share/texmf \
		XDVIETCDIR=${D}/usr/share/texmf/xdvi || die "install failed"

	dodoc ANNOUNCE BUGS FAQ README.*
	if [ -n "`use cjk`" ]; then
		dodoc CHANGES.xdvik-jp
		docinto READMEs
		dodoc READMEs/*
	fi
}
