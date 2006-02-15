# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/iftop/iftop-0.16.ebuild,v 1.16 2006/02/15 23:03:37 jokey Exp $

IUSE=""

DESCRIPTION="display bandwidth usage on an interface"
SRC_URI="http://www.ex-parrot.com/~pdw/iftop/download/${P}.tar.gz"
HOMEPAGE="http://www.ex-parrot.com/~pdw/iftop/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ia64 ~ppc sparc x86"

DEPEND="sys-libs/ncurses
	net-libs/libpcap"

src_install() {
	dosbin iftop
	doman iftop.8

	insinto /etc
	doins "${FILESDIR}"/iftoprc

	dodoc COPYING ChangeLog README
}
