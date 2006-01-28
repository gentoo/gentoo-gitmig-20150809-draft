# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/aabrowse/aabrowse-0.0.6.ebuild,v 1.3 2006/01/28 07:24:55 joshuabaergen Exp $

inherit qt3

DESCRIPTION="Server Browser for Americas Army"
HOMEPAGE="http://sourceforge.net/projects/aabrowse/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="geoip"

RDEPEND="|| ( ( x11-libs/libXext
				x11-libs/libSM )
			virtual/x11 )"
DEPEND="${RDEPEND}
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
