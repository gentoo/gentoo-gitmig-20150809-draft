# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-qosd/gmpc-qosd-0.15.0.ebuild,v 1.1 2007/06/24 17:05:20 ticho Exp $

DESCRIPTION="A on-screen-display written to look nicer then xosd."
HOMEPAGE="http://sarine.nl/q-on-screen-display"
SRC_URI="http://download.sarine.nl/gmpc-${PV}/plugins/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-sound/gmpc-${PV}
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
