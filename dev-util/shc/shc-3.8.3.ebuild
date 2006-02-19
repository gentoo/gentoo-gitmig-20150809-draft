# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/shc/shc-3.8.3.ebuild,v 1.1 2006/02/19 03:35:02 vanquirius Exp $

inherit toolchain-funcs

DESCRIPTION="A (shell-) script compiler/scrambler"
HOMEPAGE="http://www.datsi.fi.upm.es/~frosal"
SRC_URI="http://www.datsi.fi.upm.es/~frosal/sources/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~ppc ~sparc ~x86"
IUSE=""

src_compile() {
	export CC="$(tc-getCC)"

	## the "test"-target leads to an access-violation -> so we skip it
	## as it's only for demonstration purposes anyway.
	make shc || die
}

src_install() {
	dobin shc
	doman shc.1
	dodoc shc.README CHANGES
}
