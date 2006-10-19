# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/tolua/tolua-5.0.ebuild,v 1.8 2006/10/19 09:55:33 exg Exp $

inherit toolchain-funcs

DESCRIPTION="a tool that simplifies the integration of C/C++ code with Lua"
HOMEPAGE="http://www.tecgraf.puc-rio.br/~celes/tolua/"
SRC_URI="ftp://ftp.tecgraf.puc-rio.br/pub/users/celes/tolua/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE=""

DEPEND=">=dev-lang/lua-5.0"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "/^CC=/ s/=.*/=$(tc-getCC)/" \
		-e "/^LUA=/ s:=.*:=/usr:" \
		-e 's/^\(LIB=.*\)/\1 -ldl/' \
		-e "s:-O2:${CFLAGS}:" config || \
			die "sed config failed"
	sed -i \
		-e 's:make:$(MAKE):' Makefile || \
			die "sed Makefile failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin bin/tolua || die
	dolib.a lib/libtolua.a
	insinto /usr/include
	doins include/tolua.h
	dodoc INSTALL README
	dohtml doc/*
}
