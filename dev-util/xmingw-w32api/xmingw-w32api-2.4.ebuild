# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/xmingw-w32api/xmingw-w32api-2.4.ebuild,v 1.2 2003/10/28 19:51:29 cretin Exp $

DESCRIPTION="Free headers and libraries for the Win32 API"

HOMEPAGE="http://www.mingw.org"

P=${P/xmingw-}
RUNTIME=mingw-runtime-3.2

SRC_URI="mirror://sourceforge/mingw/${RUNTIME}-src.tar.gz
		mirror://sourceforge/mingw/${P}-src.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="dev-util/xmingw-binutils
		dev-util/xmingw-gcc"

S=${WORKDIR}/${P}

export PATH=$PATH:/opt/xmingw/bin:/opt/xmingw/i386-mingw32msvc/bin
unset CFLAGS CXXFLAGS

src_unpack() {
	unpack ${RUNTIME}-src.tar.gz
	unpack ${P}-src.tar.gz
	ln -s ${P} w32api
	ln -s ${RUNTIME} mingw
}

src_compile() {
	RANLIB=i386-mingw32msvc-ranlib AR=i386-mingw32msvc-ar AS=i386-mingw32msvc-as CC=i386-mingw32msvc-gcc ./configure --target=i386-mingw32msvc --prefix=/opt/xmingw/i386-mingw32msvc --build=i386-mingw32msvc || die
	make || die
}

src_install() {
	make install prefix=${D}/opt/xmingw/i386-mingw32msvc || die
}
