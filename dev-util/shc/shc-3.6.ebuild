# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/shc/shc-3.6.ebuild,v 1.1 2003/05/17 05:59:31 george Exp $

IUSE=""

DESCRIPTION="A (shell-) script compiler/scrambler."
SRC_URI="http://www.datsi.fi.upm.es/~frosal/sources/${P}.tgz"
HOMEPAGE="http://www.datsi.fi.upm.es/~frosal"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="virtual/glibc"

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
