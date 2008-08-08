# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/luafilesystem/luafilesystem-1.4.1.ebuild,v 1.1 2008/08/08 22:40:03 matsuu Exp $

inherit multilib toolchain-funcs

DESCRIPTION="File System Library for Lua"
HOMEPAGE="http://www.keplerproject.org/luafilesystem/"
SRC_URI="http://luaforge.net/frs/download.php/3345/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/lua-5.1"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s|/usr/local|/usr|" \
		-e "s|/lib|/$(get_libdir)|" \
		-e "s|-O2|${CFLAGS}|" \
		-e "s|gcc|$(tc-getCC)|" \
		config || die
}

src_install() {
	emake PREFIX="${D}usr" install || die
	dodoc README
}
