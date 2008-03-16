# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-serverstats/gmpc-serverstats-0.15.5.0.ebuild,v 1.4 2008/03/16 17:26:19 maekke Exp $

DESCRIPTION="This plugin shows more detailed information about mpd's database"
HOMEPAGE="http://sarine.nl/gmpc-plugins-serverstats"
SRC_URI="http://download.sarine.nl/gmpc-0.15.5/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

RDEPEND=">=media-sound/gmpc-${PV}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install () {
	emake DESTDIR="${D}" install || die
}
