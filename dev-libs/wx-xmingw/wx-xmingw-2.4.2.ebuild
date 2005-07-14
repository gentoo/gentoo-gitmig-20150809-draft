# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/wx-xmingw/wx-xmingw-2.4.2.ebuild,v 1.2 2005/07/14 22:15:13 agriffis Exp $


DESCRIPTION="Win32 version of wxWidgets for xmingw cross-compiler"
SRC_URI="mirror://sourceforge/wxwindows/wxAll-${PV}.tar.gz"
HOMEPAGE="http://www.wxwidgets.org/"
LICENSE="wxWinLL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug gdb monolithic mslu odbc opengl shared threads unicode"
DEPEND=">=dev-util/xmingw-runtime-3.2
	dev-util/xmingw-w32api
	dev-util/xmingw-gcc"
S=${WORKDIR}/wxWindows-${PV}


src_compile() {
	export PATH="/opt/xmingw/bin:/opt/xmingw/i386-mingw32msvc/bin:$PATH"
	export CC="i386-mingw32msvc-gcc"
	export CXX="i386-mingw32msvc-g++"

	unset CFLAGS
	unset CPPFLAGS
	unset CXXFLAGS
	unset LDFLAGS

	export CFLAGS="-I/opt/xmingw/i386-mingw32msvc/include"
	export CXXFLAGS="-I/opt/xmingw/i386-mingw32msvc/include"

	./configure \
		--prefix=/opt/xmingw/wxWidgets \
		--host=i386-mingw32msvc \
		--target=i386-mingw32msvc \
		--with-msw \
		`use_enable debug` \
		`use_enable gdb` \
		`use_enable shared` \
		`use_enable threads` \
		`use_enable monolithic` \
		`use_enable mslu` \
		`use_enable unicode` \
		`use_with opengl` \
		`use_with odbc`

	emake || die "make failed"
}

src_install() {
	cd ${WORKDIR}/wxWindows-${PV}
	make prefix=${D}/opt/xmingw/wxWidgets install || die "install failed"
}

