# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/tolua/tolua-5.0.ebuild,v 1.1 2003/08/28 12:48:44 msterret Exp $

DESCRIPTION="a tool that simplifies the integration of C/C++ code with Lua"
HOMEPAGE="http://www.tecgraf.puc-rio.br/~celes/tolua/"
SRC_URI="ftp://ftp.tecgraf.puc-rio.br/pub/users/celes/tolua/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="as-is"
SLOT="0"

DEPEND=">=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "/^CC=/ s/=.*/=${CC}/" \
		-e "/^LUA=/ s:=.*:=/usr:" \
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
	dobin bin/tolua
	dolib.a lib/libtolua.a
	insinto /usr/include
	doins include/tolua.h
	dodoc INSTALL README
	dohtml doc/*
}
