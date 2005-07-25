# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/aabrowse/aabrowse-0.0.6.ebuild,v 1.2 2005/07/25 17:45:40 caleb Exp $

inherit qt3

DESCRIPTION="Server Browser for Americas Army"
HOMEPAGE="http://sourceforge.net/projects/aabrowse/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="geoip"

DEPEND="virtual/x11
	$(qt_min_version 3.2)
	sys-libs/zlib
	media-libs/libpng
	geoip? ( >=dev-libs/geoip-1.3.0 )"

src_compile() {
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
