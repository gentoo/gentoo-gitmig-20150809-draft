# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmweather+/wmweather+-2.3.ebuild,v 1.3 2003/04/01 22:11:27 spider Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="A dockapp for displaying data collected from METAR, AVN, ETA, and MRF forecasts"
HOMEPAGE="http://www.sourceforge.net/projects/wmweatherplus/"
SRC_URI="mirror://sourceforge/wmweatherplus/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="x11-wm/WindowMaker
	dev-libs/libpcre
	net-libs/libwww"

src_install() {
	dobin wmweather+
	dodoc COPYING ChangeLog HINTS README example.conf
	doman wmweather+.1
}
