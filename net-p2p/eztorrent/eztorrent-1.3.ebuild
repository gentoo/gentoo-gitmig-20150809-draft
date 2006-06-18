# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/eztorrent/eztorrent-1.3.ebuild,v 1.1 2006/06/18 06:05:06 squinky86 Exp $

DESCRIPTION="EZtorrent simplifies the process of publishing content via BitTorrent."
HOMEPAGE="http://eztorrent.courier-mta.com/"
SRC_URI="mirror://sourceforge/eztorrent/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="virtual/bittorrent"

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
