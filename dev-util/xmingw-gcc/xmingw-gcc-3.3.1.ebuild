# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/xmingw-gcc/xmingw-gcc-3.3.1.ebuild,v 1.5 2004/04/05 08:55:40 cretin Exp $

MY_P=${P/xmingw-/}
S=${WORKDIR}/${MY_P}
MINGW_PATCH=gcc-3.3.1-20030804-1-src.diff.gz
RUNTIME=mingw-runtime-3.2
W32API=w32api-2.4

DESCRIPTION="The GNU Compiler Collection - i386-mingw32msvc-gcc only"
HOMEPAGE="http://www.gnu.org/software/gcc/gcc.html"
SRC_URI="ftp://gcc.gnu.org/pub/gcc/releases/${MY_P}/${MY_P}.tar.bz2
		mirror://sourceforge/mingw/${MINGW_PATCH}
		mirror://sourceforge/mingw/${RUNTIME}-src.tar.gz
		mirror://sourceforge/mingw/${W32API}-src.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="dev-util/xmingw-binutils"

src_unpack() {
	unpack ${MY_P}.tar.bz2
	unpack ${RUNTIME}-src.tar.gz
	unpack ${W32API}-src.tar.gz
	cd ${S}; gzip -dc ${DISTDIR}/${MINGW_PATCH} | patch -p1
	einfo "The rejects gc.h and win32_threads.c are expected, see bug #44858"
	patch -p1 < ${FILESDIR}/gcc-3.3.1-includefix.diff

	mkdir -p ${S}/winsup/cygwin ${S}/winsup/w32api
	cd ${S}/winsup/cygwin;ln -s ${WORKDIR}/${RUNTIME}/include .
	cd ${S}/winsup/w32api;ln -s ${WORKDIR}/${W32API}/include .
}

src_compile() {
	export PATH=$PATH:/opt/xmingw/bin:/opt/xmingw/i386-mingw32msvc/bin
	unset CFLAGS CXXFLAGS
	if has_version dev-util/xmingw-runtime \
	&& has_version dev-util/xmingw-w32api
	then
		lang=c,c++
	else
		lang=c
	fi

	./configure \
		--target=i386-mingw32msvc \
		--prefix=/opt/xmingw \
		--enable-languages=${lang} \
		--disable-shared \
		--disable-nls \
		--enable-threads \
		--with-gcc \
		--with-gnu-ld \
		--with-gnu-as \
		--disable-win32-registry \
		--enable-sjlj-exceptions \
		--without-x \
		--without-newlib \
			|| die "configure failed"

	emake || die "emake failed"
}

src_install() {
	export PATH=$PATH:/opt/xmingw/bin:/opt/xmingw/i386-mingw32msvc/bin
	make DESTDIR="${D}" install || die "make install failed"
}
