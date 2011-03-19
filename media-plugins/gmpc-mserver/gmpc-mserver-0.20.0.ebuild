# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-mserver/gmpc-mserver-0.20.0.ebuild,v 1.2 2011/03/19 16:46:28 angelos Exp $

EAPI=4

DESCRIPTION="This plugin allows you to play local files on a remote or local mpd
server"
HOMEPAGE="http://gmpc.wikia.com/wiki/GMPC_PLUGIN_MSERVER"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-sound/gmpc-${PV}
	dev-libs/libxml2
	media-libs/taglib
	net-libs/libmicrohttpd"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	default
	find "${ED}" -name "*.la" -delete || die
}
