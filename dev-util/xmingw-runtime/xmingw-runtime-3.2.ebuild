# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/xmingw-runtime/xmingw-runtime-3.2.ebuild,v 1.1 2003/10/28 19:50:17 cretin Exp $

DESCRIPTION="Free Win32 runtime and import library definitions"

HOMEPAGE="http://www.mingw.org"

P=${P/xming/ming}

SRC_URI="mirror://sourceforge/mingw/${P}-src.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="dev-util/xmingw-binutils
		dev-util/xmingw-gcc
		dev-util/xmingw-w32api"

S=${WORKDIR}/${P}

export PATH=$PATH:/opt/xmingw/bin:/opt/xmingw/i386-mingw32msvc/bin
unset CFLAGS CXXFLAGS

src_unpack() {
	unpack ${P}-src.tar.gz
}

src_compile() {
	RANLIB=i386-mingw32msvc-ranlib AR=i386-mingw32msvc-ar AS=i386-mingw32msvc-as CC=i386-mingw32msvc-gcc ./configure --target=i386-mingw32msvc --prefix=/opt/mingw32/i386-mingw32msvc
	cd mingwex
	make W32API_INCLUDE=-I/opt/xmingw/i386-mingw32msvc/include || die
	cd ..
	make W32API_INCLUDE=-I/opt/xmingw/i386-mingw32msvc/include || die
}

src_install() {
	make install prefix=${D}/opt/xmingw/i386-mingw32msvc || die
}
