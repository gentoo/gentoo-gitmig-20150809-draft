# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/toluapp/toluapp-1.0.92.ebuild,v 1.3 2007/03/26 09:17:13 opfer Exp $

inherit eutils toolchain-funcs

MY_PN=${PN/toluapp/tolua++}
MY_P=${MY_PN}-${PV}
DESCRIPTION="A tool to integrate C/C++ code with Lua."
HOMEPAGE="http://www.codenix.com/~tolua/"
SRC_URI="http://www.codenix.com/~tolua/${MY_P}.tar.bz2"
KEYWORDS="ppc x86"
LICENSE="as-is"
SLOT="0"
IUSE=""
S=${WORKDIR}/${MY_P}

DEPEND=">=dev-lang/lua-5.1.1
	dev-util/scons
	>=sys-apps/sed-4"

src_compile() {
	echo "## BEGIN gentoo.py

CCFLAGS = ['-I/usr/include/lua', '-O2' ]
LIBS = ['lua', 'dl', 'm']

## END gentoo.py" > ${S}/custom.py

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
