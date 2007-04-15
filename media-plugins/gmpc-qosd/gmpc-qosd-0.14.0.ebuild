# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-qosd/gmpc-qosd-0.14.0.ebuild,v 1.1 2007/04/15 15:16:00 ticho Exp $

GMPCV="0.14.0"
DESCRIPTION="A on-screen-display written to look nicer then xosd."
HOMEPAGE="http://sarine.nl/q-on-screen-display"
SRC_URI="http://download.sarine.nl/gmpc-${GMPCV}/plugins/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-sound/gmpc-${GMPCV}
		dev-libs/libxml2
		x11-libs/cairo"

src_compile ()
{
	econf || die
	emake || die
}

src_install ()
{
	make DESTDIR="${D}" install || die
}
