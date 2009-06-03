# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-lyricwiki/gmpc-lyricwiki-0.18.0.ebuild,v 1.2 2009/06/03 21:12:37 gentoofan23 Exp $

DESCRIPTION="This plugin uses lyricwiki to fetch lyrics"
HOMEPAGE="http://gmpcwiki.sarine.nl/index.php/Lyricwiki"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=media-sound/gmpc-${PV}
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install () {
	emake DESTDIR="${D}" install || die
}
