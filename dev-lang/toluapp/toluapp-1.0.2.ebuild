# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/toluapp/toluapp-1.0.2.ebuild,v 1.5 2004/10/26 15:27:02 twp Exp $

inherit eutils toolchain-funcs

MY_PN=${PN/toluapp/tolua++}
MY_P=${MY_PN}-${PV}
DESCRIPTION="A tool to integrate C/C++ code with Lua."
HOMEPAGE="http://www.codenix.com/~tolua/"
SRC_URI="http://www.codenix.com/~tolua/${MY_P}.tar.bz2"
KEYWORDS="x86 ~ppc"
LICENSE="as-is"
SLOT="0"
IUSE=""
S=${WORKDIR}/${MY_P}

DEPEND=">=dev-lang/lua-5
	dev-util/scons
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/toluapp-1.0.2-gentoo.patch
}

src_compile() {
	scons CC="$(tc-getCC)" CCFLAGS="${CFLAGS}" LINK="$(tc-getCC)" all
}

src_install() {
	dobin bin/tolua++
	dolib.a lib/libtolua++.a
	insinto /usr/include
	doins include/tolua++.h
	dodoc INSTALL README
	dohtml doc/*
}
