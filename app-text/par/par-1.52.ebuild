# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/par/par-1.52.ebuild,v 1.5 2004/09/11 15:20:19 aliz Exp $

MY_P="Par${PV/./}"

DESCRIPTION="par is a paragraph reformatter, vaguely similar to fmt, but better"
HOMEPAGE="http://www.nicemice.net/par/"
SRC_URI="http://www.nicemice.net/par/${MY_P/./}.tar.gz"
LICENSE="freedist"

SLOT="0"
KEYWORDS="~x86 ~sparc ~mips ~amd64"
IUSE=""
DEPEND="virtual/libc"
S=${WORKDIR}/${MY_P}

src_compile() {
	make -f protoMakefile CC="cc -c $CFLAGS"
}

src_install() {
	newbin par par-format
	doman par.1
	dodoc releasenotes par.doc
}
