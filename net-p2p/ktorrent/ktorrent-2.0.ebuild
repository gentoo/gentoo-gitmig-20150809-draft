# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ktorrent/ktorrent-2.0.ebuild,v 1.3 2006/08/30 18:00:18 deathwing00 Exp $

inherit kde

MY_PV="${PV/_/}"
MY_P="${PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A BitTorrent program for KDE."
HOMEPAGE="http://ktorrent.pwsp.net/"
SRC_URI="http://ktorrent.pwsp.net/downloads/${MY_PV}/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="kdeenablefinal"

DEPEND="dev-libs/gmp"

need-kde 3.3

src_compile(){
	local myconf="--enable-knetwork"
	kde_src_compile
}
