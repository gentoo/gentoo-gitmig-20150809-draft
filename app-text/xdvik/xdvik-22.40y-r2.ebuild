# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xdvik/xdvik-22.40y-r2.ebuild,v 1.10 2004/10/23 06:01:40 mr_bones_ Exp $

inherit eutils

IUSE="cjk libwww"

MY_P="${P}1"
XDVIK_JP="${MY_P}-j1.21"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="DVI previewer for X Window System"
SRC_URI="mirror://sourceforge/xdvi/${MY_P}.tar.gz
	cjk? ( http://www.nn.iij4u.or.jp/~tutimura/tex/${XDVIK_JP}.patch.gz )"
HOMEPAGE="http://sourceforge.net/projects/xdvi/"

KEYWORDS="x86 alpha amd64 arm hppa ia64 ppc ppc64 ppc-macos sparc"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-libs/t1lib-1.3
	virtual/x11
	virtual/tetex
	cjk? ( >=media-libs/freetype-2 )
	libwww? ( >=net-libs/libwww-5.3.2-r1 )"

src_unpack () {

	unpack ${MY_P}.tar.gz
	if use cjk ; then
		epatch ${DISTDIR}/${XDVIK_JP}.patch.gz
		sed -i -e "/\/usr\/local/s/^/%/g" \
			-e "/kochi-.*-subst/s/%//g" \
			${S}/texk/xdvik/vfontmap.freetype || die
	fi
}

src_compile () {

	local myconf

	if use cjk ; then
		 export CPPFLAGS="${CPPFLAGS} -I/usr/include/freetype2"
		 myconf="${myconf} --with-vflib=vf2ft"
	fi

	econf --enable-xdvietcdir=/usr/share/texmf/xdvi \
		--disable-multiplatform \
		--with-system-t1lib \
		`use_with libwww system-wwwlib` \
		${myconf} || die "econf failed"

	cd texk/xdvik
	make || die
}

src_install () {

	dodir /usr/share/texmf/xdvi
	dodir /usr/share/man/man1

	cd ${S}/texk/xdvik
	einstall texmf=${D}/usr/share/texmf \
		XDVIETCDIR=${D}/usr/share/texmf/xdvi \
		|| die "install failed"

	dodoc ANNOUNCE BUGS FAQ README.*
	if use cjk; then
		dodoc CHANGES.xdvik-jp
		docinto READMEs
		dodoc READMEs/*
	fi
}
