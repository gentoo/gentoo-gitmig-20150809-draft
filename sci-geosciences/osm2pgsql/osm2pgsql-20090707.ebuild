# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/osm2pgsql/osm2pgsql-20090707.ebuild,v 1.1 2009/07/08 12:55:19 tupone Exp $
EAPI=2

inherit eutils

DESCRIPTION="converts OpenStreetMap data into a format for PostgreSQL"
HOMEPAGE="http://wiki.openstreetmap.org/wiki/Osm2pgsql"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-libs/libxml2
	sci-libs/proj
	sci-libs/geos
	dev-db/postgis"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch debian/patches/01_style_location
}

src_install() {
	dodoc README.txt
	dobin mapnik-osm-updater.sh osm2pgsql
	doman debian/osm2pgsql.1
	insinto /usr/share/${PN}
	doins default.style
}
