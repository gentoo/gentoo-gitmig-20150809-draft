# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/luabind/luabind-6.ebuild,v 1.2 2004/04/06 21:35:52 rphillips Exp $

S=${WORKDIR}/luabind
DESCRIPTION="C++ library that helps to create bindings for Lua"
HOMEPAGE="http://luabind.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-b${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="dev-lang/lua
	dev-libs/boost"

src_compile() {
	einfo "No compilation necessary"
}

src_install() {
	dodoc doc/*
	insinto /usr/include/luabind
	doins luabind/*
	insinto /usr/include/luabind/detail
	doins luabind/detail/*
}
