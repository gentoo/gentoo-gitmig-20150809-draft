# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/cli-crypt/cli-crypt-1.0.ebuild,v 1.1 2002/07/10 18:13:33 rphillips Exp $

DESCRIPTION="Command-line interface to crypt(3)"
HOMEPAGE="http://freshmeat.net/projects/cli-crypt/"
LICENSE="GPL"
DEPEND="virtual/glibc"
RDEPEND="virtual/glibc"
SRC_URI="http://www.xjack.org/downloads/${P}.tar.gz"

src_compile() {
		set ${CC:=gcc}
		make CC="${CC}" CFLAGS="${CFLAGS} -lcrypt"
}

src_install() {
		insinto /usr
		dobin crypt
}
