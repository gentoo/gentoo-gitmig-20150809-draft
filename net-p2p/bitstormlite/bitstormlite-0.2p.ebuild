# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/bitstormlite/bitstormlite-0.2p.ebuild,v 1.1 2007/12/04 15:26:27 armin76 Exp $

DESCRIPTION="A light BitTorrent client based on c++ and gtk+."
HOMEPAGE="http://sourceforge.net/projects/bbom/"
SRC_URI="mirror://sourceforge/bbom/BitStormLite-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="net-misc/curl
		dev-util/pkgconfig
		>=x11-libs/gtk+-2.6"

S="${WORKDIR}/BitStormLite-${PV}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
