# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/wire/wire-1.0.2.ebuild,v 1.1 2004/08/15 22:18:50 kang Exp $

DESCRIPTION="Wire is the Wired command line client"
HOMEPAGE="http://www.zankasoftware.com/wired/wire/"
SRC_URI="http://www.zankasoftware.com/dist/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~x86"

IUSE=""


DEPEND="( >=dev-libs/openssl-0.9.7d )
		( >=sys-libs/readline-4.3)"

src_compile() {
	econf || die "configure: failure"
	emake || die "make: failure"
}

src_install() {
	dodoc INSTALL LICENSE README
	doman man/wire.1
	dobin run/wire
}
