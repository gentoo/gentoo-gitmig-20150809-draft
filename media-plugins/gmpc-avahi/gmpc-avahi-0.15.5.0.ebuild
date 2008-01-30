# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-avahi/gmpc-avahi-0.15.5.0.ebuild,v 1.2 2008/01/30 01:58:32 cla Exp $

DESCRIPTION="This plugin discovers avahi enabled mpd servers"
HOMEPAGE="http://sarine.nl/gmpc-plugins"
SRC_URI="http://download.sarine.nl/gmpc-0.15.5/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-sound/gmpc-${PV}
	dev-libs/libxml2
	net-dns/avahi"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install () {
	emake DESTDIR="${D}" install || die
}
