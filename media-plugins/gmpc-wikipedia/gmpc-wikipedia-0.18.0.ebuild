# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-wikipedia/gmpc-wikipedia-0.18.0.ebuild,v 1.1 2009/03/13 13:05:45 angelos Exp $

DESCRIPTION="This plugin shows the Wikipedia article about the currently playing artist"
HOMEPAGE="http://gmpc.wikia.com/wiki/Wikipedia"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-sound/gmpc-${PV}
	dev-libs/libxml2
	net-libs/webkit-gtk"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install () {
	emake DESTDIR="${D}" install || die "emake failed"
}
