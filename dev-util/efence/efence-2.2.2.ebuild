# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/efence/efence-2.2.2.ebuild,v 1.3 2002/07/11 06:30:25 drobbins Exp $

S=${WORKDIR}/ElectricFence-${PV}
DESCRIPTION="malloc() debugger for Linux and Unix."
SRC_URI="ftp://ftp.perens.com/pub/ElectricFence/Beta/ElectricFence-${PV}.tar.gz"
HOMEPAGE="http://perens.com/FreeSoftware/"

DEPEND="virtual/glibc"

src_compile() {
	emake || die
}

src_install () {
	dodir /usr/bin
	dodir /usr/lib
	dodir /usr/share/man/man3

	make BIN_INSTALL_DIR=${D}/usr/bin				\
	     LIB_INSTALL_DIR=${D}/usr/lib				\
	     MAN_INSTALL_DIR=${D}/usr/share/man/man3			\
	     install
	assert "Installation of package failed."

	dodoc CHANGES COPYING README
}
