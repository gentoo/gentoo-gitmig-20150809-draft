# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/iftop/iftop-0.17.ebuild,v 1.1 2006/06/05 16:41:08 pva Exp $

inherit eutils

DESCRIPTION="display bandwidth usage on an interface"
SRC_URI="http://www.ex-parrot.com/~pdw/iftop/download/${P}.tar.gz"
HOMEPAGE="http://www.ex-parrot.com/~pdw/iftop/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="sys-libs/ncurses
	net-libs/libpcap"

src_unpack() {
	unpack ${A}; cd "${S}"
	# bug 101926
	epatch "${FILESDIR}"/${PN}-0.16-bar_in_bytes.patch
}

src_install() {
	dosbin iftop
	doman iftop.8

	insinto /etc
	doins "${FILESDIR}"/iftoprc

	dodoc ChangeLog README
}
