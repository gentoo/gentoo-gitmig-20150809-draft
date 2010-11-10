# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ctcs/ctcs-1.4.1.ebuild,v 1.4 2010/11/10 00:12:08 hwoarang Exp $

DESCRIPTION="interface for monitoring and managing Enhanced CTorrent clients"
HOMEPAGE="http://www.rahul.net/dholmes/ctorrent/ctcs.html"
SRC_URI="http://www.rahul.net/dholmes/ctorrent/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-lang/perl
	>=net-p2p/ctorrent-3.3.1"

src_install() {
	dobin ctcs || die
	dodoc readme.txt
}
