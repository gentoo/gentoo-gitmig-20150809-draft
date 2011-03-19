# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-last-fm/gmpc-last-fm-0.20.0.ebuild,v 1.9 2011/03/19 16:40:49 angelos Exp $

EAPI=3

DESCRIPTION="This plugin fetches artist art from last.fm"
HOMEPAGE="http://gmpc.wikia.com/wiki/GMPC_PLUGIN_LASTFM"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=media-sound/gmpc-${PV}
	dev-libs/libxml2
	|| ( x11-libs/gdk-pixbuf:2[jpeg] x11-libs/gtk+:2[jpeg] )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	find "${ED}" -name "*.la" -delete || die
}
