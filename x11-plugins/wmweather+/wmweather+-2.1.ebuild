# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmweather+/wmweather+-2.1.ebuild,v 1.1 2002/11/02 21:10:07 raker Exp $

DESCRIPTION="A dockapp for displaying data collected from METAR, AVN, ETA, and MRF forecasts"
HOMEPAGE="http://www.sourceforge.net/projects/wmweatherplus/"
SRC_URI="mirror://sourceforge/wmweatherplus/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE=""

DEPEND="virtual/glibc
	virtual/x11
	x11-wm/WindowMaker
	media-libs/xpm
	net-libs/libwww"

S="${WORKDIR}/${P}"

src_compile() {

	econf || die "configure failed"

	emake || die "parallel make failed"

}

src_install() {

	dobin wmweather+

	dodoc COPYING ChangeLog HINTS README example.conf

	doman wmweather+.1

}
