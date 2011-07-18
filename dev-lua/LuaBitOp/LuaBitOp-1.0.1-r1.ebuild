# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lua/LuaBitOp/LuaBitOp-1.0.1-r1.ebuild,v 1.2 2011/07/18 15:21:28 hwoarang Exp $

EAPI="4"
inherit multilib

DESCRIPTION="Bit Operations Library for the Lua Programming Language"
HOMEPAGE="http://bitop.luajit.org"
SRC_URI="http://bitop.luajit.org/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=dev-lang/lua-5.1*"
RDEPEND="${DEPEND}"

src_prepare()
{
	sed -i \
		-e '/^CFLAGS.*=/s/=/ +=/' \
		-e '/^CFLAGS/s/-O2 -fomit-frame-pointer //' \
		Makefile || die "sed failed"
}

src_compile()
{
	emake CC="$(tc-getCC)"
}

src_test()
{
	make test
}

src_install()
{
	exeinto /usr/$(get_libdir)/lua/5.1
doexe bit.so
	dohtml -r doc/*
}
