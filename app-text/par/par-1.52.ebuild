# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/par/par-1.52.ebuild,v 1.6 2004/10/26 13:35:11 vapier Exp $

inherit toolchain-funcs

MY_P="Par${PV/./}"
DESCRIPTION="a paragraph reformatter, vaguely similar to fmt, but better"
HOMEPAGE="http://www.nicemice.net/par/"
SRC_URI="http://www.nicemice.net/par/${MY_P/./}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~amd64 ~mips ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${MY_P}

src_compile() {
	make -f protoMakefile CC="$(tc-getCC) -c $CFLAGS"
}

src_install() {
	newbin par par-format || die
	doman par.1
	dodoc releasenotes par.doc
}
