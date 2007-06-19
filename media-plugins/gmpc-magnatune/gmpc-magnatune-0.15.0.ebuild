# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-magnatune/gmpc-magnatune-0.15.0.ebuild,v 1.1 2007/06/19 14:10:43 ticho Exp $

DESCRIPTION="The plugin allows you to browse, and preview available albums on www.magnatune.com."
HOMEPAGE="http://sarine.nl/gmpc-plugins-lyrics-magnatune"
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
