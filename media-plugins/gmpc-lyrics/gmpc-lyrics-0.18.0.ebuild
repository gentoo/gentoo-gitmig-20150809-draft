# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-lyrics/gmpc-lyrics-0.18.0.ebuild,v 1.6 2011/02/13 18:00:29 armin76 Exp $

DESCRIPTION="This plugin fetches lyrics"
HOMEPAGE="http://gmpcwiki.sarine.nl/index.php/Lyrics"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=media-sound/gmpc-${PV}
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install () {
	emake DESTDIR="${D}" install || die
}
