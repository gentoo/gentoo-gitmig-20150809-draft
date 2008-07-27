# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/aabrowse/aabrowse-0.0.8.ebuild,v 1.7 2008/07/27 21:34:12 carlo Exp $

EAPI=1

inherit kde

DESCRIPTION="Server Browser for Americas Army"
HOMEPAGE="http://sourceforge.net/projects/aabrowse/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="geoip"

RDEPEND="x11-libs/libXext
	x11-libs/libSM"
DEPEND="${RDEPEND}
	x11-libs/qt:3
	sys-libs/zlib
	media-libs/libpng
	geoip? ( >=dev-libs/geoip-1.3.0 )"

src_compile() {
	kde_src_compile nothing
	export WANT_AUTOCONF=2.5
	econf \
		--disable-dependency-tracking \
		$(use_enable geoip) || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog NEWS README TODO
}
