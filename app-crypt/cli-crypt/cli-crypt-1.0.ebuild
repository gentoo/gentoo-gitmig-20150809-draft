# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/cli-crypt/cli-crypt-1.0.ebuild,v 1.8 2004/02/22 18:10:39 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Command-line interface to crypt(3)"
HOMEPAGE="http://freshmeat.net/projects/cli-crypt/"
SRC_URI="http://www.xjack.org/downloads/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"

DEPEND="virtual/glibc"

src_compile() {
	set ${CC:=gcc}
	make CC="${CC}" CFLAGS="${CFLAGS} -lcrypt"
}

src_install() {
	insinto /usr
	dobin crypt
}
