# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-serverstats/gmpc-serverstats-0.15.0.ebuild,v 1.2 2007/06/24 17:21:41 angelos Exp $

DESCRIPTION="This plugin shows more detailed information about mpd's database."
HOMEPAGE="http://sarine.nl/gmpc-plugins-serverstats"
SRC_URI="http://download.sarine.nl/gmpc-${PV}/plugins/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND=">=media-sound/gmpc-${PV}"

src_compile ()
{
	econf || die
	emake || die
}

src_install ()
{
	make DESTDIR="${D}" install || die
}
