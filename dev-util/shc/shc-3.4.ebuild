# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/shc/shc-3.4.ebuild,v 1.1 2003/01/06 05:26:09 george Exp $

IUSE=""

DESCRIPTION="A (shell-) script compiler/scrambler."
SRC_URI="http://www.datsi.fi.upm.es/~frosal/sources/${P}.tgz"
HOMEPAGE="http://www.datsi.fi.upm.es/~frosal"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~sparc64 ~alpha"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${P}.tgz
	cd ${S}
}

src_compile() {
	## the "test"-target leads to an access-violation -> so we skip it
	## as it's only for demonstration purposes anyway.
	make shc || die
}

src_install () {
	exeinto /usr/bin
	doexe shc
	doman shc.1
	dodoc shc.README CHANGES
}
