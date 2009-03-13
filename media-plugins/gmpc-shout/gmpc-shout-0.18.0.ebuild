# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-shout/gmpc-shout-0.18.0.ebuild,v 1.1 2009/03/13 12:08:33 angelos Exp $

DESCRIPTION="This plugin calls ogg123 and points it at mpd's shoutstream"
HOMEPAGE="http://gmpc.wikia.com/wiki/GMPC_PLUGIN_SHOUT"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-sound/gmpc-${PV}
	media-sound/vorbis-tools
	dev-libs/libxml2
	x11-libs/cairo"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install () {
	emake DESTDIR="${D}" install || die "emake failed"
}
