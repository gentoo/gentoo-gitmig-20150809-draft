# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/lastfmlib/lastfmlib-0.3.0.ebuild,v 1.2 2009/07/13 07:43:06 hwoarang Exp $

EAPI="2"

inherit eutils

DESCRIPTION="C++ library to scrobble tracks on Last.fm"
HOMEPAGE="http://code.google.com/p/lastfmlib"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="syslog debug"

RDEPEND="net-misc/curl"
DEPEND="${RDEPEND}"

src_configure() {
	econf \
	$(use_enable syslog logging) \
	$(use_enable debug) \
	--disable-unittests || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README TODO || die "dodoc failed"
}
