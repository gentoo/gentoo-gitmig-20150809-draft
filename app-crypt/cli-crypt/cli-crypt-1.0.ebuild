# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/cli-crypt/cli-crypt-1.0.ebuild,v 1.16 2005/05/30 18:05:10 swegener Exp $

inherit toolchain-funcs

DESCRIPTION="Command-line interface to crypt(3)"
HOMEPAGE="http://freshmeat.net/projects/cli-crypt/"
SRC_URI="http://www.xjack.org/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS} -lcrypt" || die
}

src_install() {
	dobin crypt || die
}
