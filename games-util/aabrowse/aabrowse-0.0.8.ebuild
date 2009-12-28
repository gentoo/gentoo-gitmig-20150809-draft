# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/aabrowse/aabrowse-0.0.8.ebuild,v 1.9 2009/12/28 17:45:44 ssuominen Exp $

EAPI=2
inherit qt3

DESCRIPTION="Server Browser for Americas Army"
HOMEPAGE="http://sourceforge.net/projects/aabrowse/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="geoip"

RDEPEND="x11-libs/libXext
	x11-libs/libSM"
DEPEND="${RDEPEND}
	x11-libs/qt:3
	sys-libs/zlib
	media-libs/libpng
	geoip? ( >=dev-libs/geoip-1.3.0 )"

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable geoip)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog NEWS README TODO
}
