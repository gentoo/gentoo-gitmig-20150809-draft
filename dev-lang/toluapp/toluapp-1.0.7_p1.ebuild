# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/toluapp/toluapp-1.0.7_p1.ebuild,v 1.1 2006/04/05 21:24:44 twp Exp $

inherit eutils toolchain-funcs

MY_PN=${PN/toluapp/tolua++}
MY_PV=${PV/_p/-}
MY_P=${MY_PN}_${MY_PV}
DESCRIPTION="A tool to integrate C/C++ code with Lua."
HOMEPAGE="http://www.codenix.com/~tolua/"
SRC_URI="http://www.codenix.com/~tolua/${MY_P}.tar.gz"
KEYWORDS="~x86 ~ppc"
LICENSE="as-is"
SLOT="0"
IUSE=""
S=${WORKDIR}/${MY_PN}-${PV/_*/}

DEPEND=">=dev-lang/lua-5
	dev-util/scons
	>=sys-apps/sed-4"

src_compile() {
	sed -i -e "s/lua50/lua/g" -e "s/lualib50/lualib/" ${S}/config_linux.py
	scons \
		CC=$(tc-getCC) \
		CCFLAGS="${CFLAGS}" \
		LINK=$(tc-getCC) \
		prefix=${D}/usr \
		install || die
}

src_install() {
	dobin bin/tolua++
	dolib.a lib/libtolua++.a
	insinto /usr/include
	doins include/tolua++.h
	dodoc INSTALL README
	dohtml doc/*
}
