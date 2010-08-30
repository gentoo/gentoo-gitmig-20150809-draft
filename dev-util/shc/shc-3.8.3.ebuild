# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/shc/shc-3.8.3.ebuild,v 1.2 2010/08/30 22:22:02 xmw Exp $

EAPI=2

inherit toolchain-funcs

DESCRIPTION="A (shell-) script compiler/scrambler"
HOMEPAGE="http://www.datsi.fi.upm.es/~frosal"
SRC_URI="http://www.datsi.fi.upm.es/~frosal/sources/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~ppc ~sparc ~x86"
IUSE=""

RESTRICT="test"

src_prepare() {
	# respect LDFLAGS
	sed -i -e 's:$(CC) $(CFLAGS):\0 $(LDFLAGS):' Makefile || die
	# do not strip by install -s
	sed -i -e '/install/s: -s : :' Makefile || die
}

src_compile() {
	export CC="$(tc-getCC)"

	## the "test"-target leads to an access-violation -> so we skip it
	## as it's only for demonstration purposes anyway.
	emake shc CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin shc || die
	doman shc.1 || die
	dodoc shc.README CHANGES || die
}
