# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ctcs/ctcs-1.2.ebuild,v 1.1 2007/01/16 19:20:10 armin76 Exp $

DESCRIPTION="Interface for monitoring and managing Enhanced CTorrent clients"
HOMEPAGE="http://www.rahul.net/dholmes/ctorrent/ctcs.html"
SRC_URI="http://www.rahul.net/dholmes/ctorrent/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-lang/perl
	>=net-p2p/ctorrent-2.2"

src_install() {
	newbin ctcs.new ctcs
	dodoc readme.txt
}
