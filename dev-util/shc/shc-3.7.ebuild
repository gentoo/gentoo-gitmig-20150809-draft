# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/shc/shc-3.7.ebuild,v 1.6 2007/08/13 20:50:43 dertobi123 Exp $

DESCRIPTION="A (shell-) script compiler/scrambler"
HOMEPAGE="http://www.datsi.fi.upm.es/~frosal"
SRC_URI="http://www.datsi.fi.upm.es/~frosal/sources/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ppc ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	## the "test"-target leads to an access-violation -> so we skip it
	## as it's only for demonstration purposes anyway.
	make shc || die
}

src_install() {
	dobin shc
	doman shc.1
	dodoc shc.README CHANGES
}
