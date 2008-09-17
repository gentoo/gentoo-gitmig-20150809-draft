# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/lxsplit/lxsplit-0.2.3.ebuild,v 1.1 2008/09/17 11:04:46 pva Exp $

inherit toolchain-funcs

DESCRIPTION="Command-line file splitter/joiner for Linux"
HOMEPAGE="http://lxsplit.sourceforge.net"
SRC_URI="mirror://sourceforge/lxsplit/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

src_compile() {
	tc-export CC
	emake CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	dobin lxsplit || die
	dodoc ChangeLog README
}
