# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/xmingw-w32api/xmingw-w32api-3.1.ebuild,v 1.3 2004/11/17 16:58:53 cretin Exp $

inherit eutils

MY_P=${P/xmingw-}
RUNTIME=mingw-runtime-3.5
S=${WORKDIR}/${MY_P}

DESCRIPTION="Free headers and libraries for the Win32 API"
HOMEPAGE="http://www.mingw.org"
SRC_URI="mirror://sourceforge/mingw/${RUNTIME}-src.tar.gz
		mirror://sourceforge/mingw/${MY_P}-src.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="dev-util/xmingw-binutils
		dev-util/xmingw-gcc"

src_unpack() {
	unpack ${RUNTIME}-src.tar.gz
	unpack ${MY_P}-src.tar.gz
	ln -s ${MY_P} w32api
	ln -s ${RUNTIME} mingw
	epatch ${FILESDIR}/xmingw-w32api-3.1-include.patch
	epatch ${FILESDIR}/xmingw-w32api-3.1-ntddk.patch
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
			--prefix=/opt/xmingw/i386-mingw32msvc \
			--build=i386-mingw32msvc \
				|| die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make install prefix=${D}/opt/xmingw/i386-mingw32msvc \
		|| die "make install failed"
}
