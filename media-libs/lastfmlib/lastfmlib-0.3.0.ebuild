# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/lastfmlib/lastfmlib-0.3.0.ebuild,v 1.5 2009/11/03 19:32:35 fauli Exp $

EAPI=2

DESCRIPTION="C++ library to scrobble tracks on Last.fm"
HOMEPAGE="http://code.google.com/p/lastfmlib"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="syslog debug"

DEPEND="net-misc/curl
	!media-libs/liblastfm"

src_configure() {
	econf \
		$(use_enable syslog logging) \
		$(use_enable debug) \
		--disable-unittests
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO || die
}
