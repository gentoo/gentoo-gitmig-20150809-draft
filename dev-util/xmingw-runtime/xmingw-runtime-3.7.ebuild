# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/xmingw-runtime/xmingw-runtime-3.7.ebuild,v 1.2 2006/07/28 11:39:13 fmccor Exp $

inherit eutils

MY_P=${P/xming/ming}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Free Win32 runtime and import library definitions"
HOMEPAGE="http://www.mingw.org"
SRC_URI="mirror://sourceforge/mingw/${MY_P}-src.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""
DEPEND="dev-util/xmingw-binutils
		dev-util/xmingw-gcc
		dev-util/xmingw-w32api"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-3.5-inc.patch
}

src_compile() {
	export PATH=$PATH:/opt/xmingw/bin:/opt/xmingw/i386-mingw32msvc/bin
	unset CFLAGS CXXFLAGS

	RANLIB=i386-mingw32msvc-ranlib \
	AR=i386-mingw32msvc-ar \
	AS=i386-mingw32msvc-as \
	CC=i386-mingw32msvc-gcc \
		./configure \
			--target=i386-mingw32msvc \
			--prefix=/opt/mingw32/i386-mingw32msvc \
				|| die "configure failed"
	cd mingwex
	make W32API_INCLUDE=-I/opt/xmingw/i386-mingw32msvc/include || die
	cd ..
	make W32API_INCLUDE=-I/opt/xmingw/i386-mingw32msvc/include || die
}

src_install() {
	make install prefix=${D}/opt/xmingw/i386-mingw32msvc \
		|| die  "make install failed"
}
