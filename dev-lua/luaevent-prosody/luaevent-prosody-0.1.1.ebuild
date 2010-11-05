# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lua/luaevent-prosody/luaevent-prosody-0.1.1.ebuild,v 1.1 2010/11/05 20:03:27 rafaelmartins Exp $

EAPI=2

inherit multilib toolchain-funcs flag-o-matic eutils

DESCRIPTION="libevent bindings for Lua (Prosody's fork)"
HOMEPAGE="http://code.matthewwild.co.uk/luaevent-prosody"
SRC_URI="http://matthewwild.co.uk/uploads/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/lua-5.1
		>=dev-libs/libevent-1.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	sed -i -e "s#^INSTALL_DIR_LUA=.*#INSTALL_DIR_LUA=$(pkg-config --variable INSTALL_LMOD lua)#" "${S}/Makefile"
	sed -i -e "s#^INSTALL_DIR_BIN=.*#INSTALL_DIR_BIN=$(pkg-config --variable INSTALL_CMOD lua)#" "${S}/Makefile"
	sed -i -e "s#^LUA_INC_DIR=.*#LUA_INC_DIR=$(pkg-config --variable INSTALL_INC lua)#" "${S}/Makefile"
	sed -i -e "s#^LUA_LIB_DIR=.*#LUA_LIB_DIR=$(pkg-config --variable INSTALL_LIB lua)#" "${S}/Makefile"
	sed -i -e "s#^LUA_LIB =.*#LUA_LIB=lua#" "${S}/Makefile"
}

src_compile() {
	append-flags -fPIC -c
	emake \
		CFLAGS="${LDFLAGS} ${CFLAGS}" \
		LDFLAGS="${LDFLAGS} -shared" \
		CC="$(tc-getCC)" \
		LD="$(tc-getCC) -shared" \
		all \
		|| die
}

src_install() {
	emake \
		CFLAGS="${LDFLAGS} ${CFLAGS}" \
		LDFLAGS="${LDFLAGS} -shared" \
		CC="$(tc-getCC)" \
		DESTDIR="${D}" install || die "Install failed"
}
