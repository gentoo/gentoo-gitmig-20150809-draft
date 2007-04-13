# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ctcs/ctcs-1.3.ebuild,v 1.1 2007/04/13 20:30:11 drac Exp $

DESCRIPTION="Interface for monitoring and managing Enhanced CTorrent clients"
HOMEPAGE="http://www.rahul.net/dholmes/ctorrent/ctcs.html"
SRC_URI="http://www.rahul.net/dholmes/ctorrent/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-lang/perl
	>=net-p2p/ctorrent-3"

src_install() {
	dobin ctcs
	dodoc readme.txt
}
