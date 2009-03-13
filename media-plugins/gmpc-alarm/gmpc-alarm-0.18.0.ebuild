# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-alarm/gmpc-alarm-0.18.0.ebuild,v 1.1 2009/03/13 11:32:57 angelos Exp $

DESCRIPTION="This plugin can start/stop/pause your music at a preset time"
HOMEPAGE="http://gmpcwiki.sarine.nl/index.php/Alarm"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=media-sound/gmpc-${PV}
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install () {
	emake DESTDIR="${D}" install || die "emake failed"
}
