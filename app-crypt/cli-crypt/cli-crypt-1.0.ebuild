# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/cli-crypt/cli-crypt-1.0.ebuild,v 1.4 2002/08/16 02:36:53 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Command-line interface to crypt(3)"
HOMEPAGE="http://freshmeat.net/projects/cli-crypt/"
SRC_URI="http://www.xjack.org/downloads/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

src_compile() {
	set ${CC:=gcc}
	make CC="${CC}" CFLAGS="${CFLAGS} -lcrypt"
}

src_install() {
	insinto /usr
	dobin crypt
}
