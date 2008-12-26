# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-lyricwiki/gmpc-lyricwiki-0.17.0.ebuild,v 1.1 2008/12/26 19:46:20 angelos Exp $

DESCRIPTION="This plugin uses lyricwiki to fetch lyrics"
HOMEPAGE="http://gmpcwiki.sarine.nl/index.php/Lyricwiki"
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
	emake DESTDIR="${D}" install || die
}
