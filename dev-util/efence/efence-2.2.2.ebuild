# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/efence/efence-2.2.2.ebuild,v 1.9 2003/02/13 11:51:47 vapier Exp $

MY_P="ElectricFence-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="malloc() debugger for Linux and Unix."
SRC_URI="ftp://ftp.perens.com/pub/ElectricFence/Beta/${MY_P}.tar.gz"
HOMEPAGE="http://perens.com/FreeSoftware/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

DEPEND="virtual/glibc"

src_compile() {
	emake || die
}

src_install () {
	dodir /usr/bin
	dodir /usr/lib
	dodir /usr/share/man/man3

	make \
		BIN_INSTALL_DIR=${D}/usr/bin \
		LIB_INSTALL_DIR=${D}/usr/lib \
		MAN_INSTALL_DIR=${D}/usr/share/man/man3 \
		install || die

	dodoc CHANGES COPYING README
}
