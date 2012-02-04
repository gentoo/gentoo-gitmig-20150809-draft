# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/leechcraft-bittorrent/leechcraft-bittorrent-0.4.99.ebuild,v 1.2 2012/02/04 19:19:21 ago Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Full-featured BitTorrent client plugin for LeechCraft."

SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
		net-libs/rb_libtorrent"
RDEPEND="${DEPEND}
		virtual/leechcraft-task-show"
