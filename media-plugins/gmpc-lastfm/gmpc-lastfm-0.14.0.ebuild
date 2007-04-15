# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-lastfm/gmpc-lastfm-0.14.0.ebuild,v 1.2 2007/04/15 15:31:51 ticho Exp $

DESCRIPTION="The last.fm plugin can fetch artist images, from last.fm. This plugin doesn't scrobble your music, use a dedicated client like mpdscribble for this."
HOMEPAGE="http://sarine.nl/gmpc-plugins-lastfm"
SRC_URI="http://download.sarine.nl/gmpc-${PV}/plugins/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-sound/gmpc-${PV}
		dev-libs/libxml2"

src_compile ()
{
	econf || die
	emake || die
}

src_install ()
{
	make DESTDIR="${D}" install || die
}
