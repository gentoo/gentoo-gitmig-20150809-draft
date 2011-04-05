# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lua/LuaBitOp/LuaBitOp-1.0.1.ebuild,v 1.1 2011/04/05 23:23:41 williamh Exp $

EAPI="4"
inherit multilib

DESCRIPTION="Bit Operations Library for the Lua Programming Language"
HOMEPAGE="http://bitop.luajit.org"
SRC_URI="http://bitop.luajit.org/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="=dev-lang/lua-5.1*"
RDEPEND="${DEPEND}"

src_prepare()
{
	sed -i \
		-e "/^CC=/d" \
		-e "/^INCLUDES=/d" \
		-e "/^CFLAGS=/s|=| +=|" \
		-e "s|/usr/local|/usr|" \
		-e "s|-O2 -fomit-frame-pointer||" \
		-e "s|\$(INCLUDES)||" \
		Makefile || die "sed failed"
}

src_compile()
{
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}"
}

src_install()
{
	exeinto /usr/$(get_libdir)/lua/5.1
doexe bit.so
	dohtml -r doc/*
}
