# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/osm2mp/osm2mp-0.60.ebuild,v 1.1 2008/12/27 16:55:57 hanno Exp $

DESCRIPTION="Converts openstreetmap data to mp format (used e. g. by mkgmap)"
HOMEPAGE="http://forum.openstreetmap.org/viewtopic.php?id=1162"
SRC_URI="http://garminmapsearch.com/osm/${PN}_v${PV/./}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="dev-perl/Template-Toolkit
	virtual/perl-Getopt-Long"
S="${WORKDIR}"

src_compile() {
	sed -i -e 's:poi.cfg:/usr/share/osm2mp/poi.cfg:g' \
		-e 's:poly.cfg:/usr/share/osm2mp/poly.cfg:g' \
		-e 's:header.tpl:/usr/share/osm2mp/header.tpl:g' \
		osm2mp.pl
}

src_install() {
	dobin osm2mp.pl
	insinto /usr/share/osm2mp
	doins poi.cfg poly.cfg header.tpl
	dodoc todo
}
