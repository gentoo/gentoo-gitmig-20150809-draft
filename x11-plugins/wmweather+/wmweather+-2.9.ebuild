# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmweather+/wmweather+-2.9.ebuild,v 1.4 2004/09/02 18:22:41 pvdabeel Exp $

IUSE=""
DESCRIPTION="A dockapp for displaying data collected from METAR, AVN, ETA, and MRF forecasts"
HOMEPAGE="http://www.sourceforge.net/projects/wmweatherplus/"
SRC_URI="mirror://sourceforge/wmweatherplus/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64 ~mips ~sparc ppc"

DEPEND="x11-wm/windowmaker
	dev-libs/libpcre
	net-libs/libwww"

src_install() {
	dobin wmweather+
	dodoc COPYING ChangeLog HINTS README example.conf
	doman wmweather+.1
}
