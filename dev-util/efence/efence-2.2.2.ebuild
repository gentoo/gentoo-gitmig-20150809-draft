# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/efence/efence-2.2.2.ebuild,v 1.12 2004/04/10 07:02:10 mr_bones_ Exp $

inherit gcc

MY_P="ElectricFence-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="malloc() debugger for Linux and Unix"
HOMEPAGE="http://perens.com/FreeSoftware/"
SRC_URI="ftp://ftp.perens.com/pub/ElectricFence/Beta/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND="virtual/glibc"

src_compile() {
	emake CC="$(gcc-getCC)" || die "emake failed"
}

src_install() {
	dodir /usr/bin /usr/lib /usr/share/man/man3
	make \
		BIN_INSTALL_DIR="${D}/usr/bin" \
		LIB_INSTALL_DIR="${D}/usr/lib" \
		MAN_INSTALL_DIR="${D}/usr/share/man/man3" \
		install || die "make install failed"
	dodoc CHANGES README
}
