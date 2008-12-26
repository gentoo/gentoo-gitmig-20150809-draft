# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-serverstats/gmpc-serverstats-0.17.0.ebuild,v 1.1 2008/12/26 19:57:09 angelos Exp $

DESCRIPTION="This plugin shows more detailed information about mpd's database"
HOMEPAGE="http://gmpcwiki.sarine.nl/index.php/Server_statistics"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=media-sound/gmpc-${PV}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install () {
	emake DESTDIR="${D}" install || die
}
