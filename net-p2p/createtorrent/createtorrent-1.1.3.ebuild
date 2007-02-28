# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/createtorrent/createtorrent-1.1.3.ebuild,v 1.1 2007/02/28 22:55:09 armin76 Exp $

inherit eutils

DESCRIPTION="Create BitTorrent files easily"
HOMEPAGE="http://www.creatorrent.com/"
SRC_URI="http://www.createtorrent.com/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
}
