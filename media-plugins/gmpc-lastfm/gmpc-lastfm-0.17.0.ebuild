# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-lastfm/gmpc-lastfm-0.17.0.ebuild,v 1.2 2009/01/03 23:51:28 angelos Exp $

EAPI=2

MY_PN="gmpc-last-fm"
MY_P=${MY_PN}-${PV}

DESCRIPTION="This plugin fetches artist art from last.fm"
HOMEPAGE="http://gmpcwiki.sarine.nl/index.php/Last.fm"
SRC_URI="mirror://sourceforge/musicpd/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=media-sound/gmpc-${PV}
	dev-libs/libxml2
	x11-libs/gtk+:2[jpeg]"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
}
