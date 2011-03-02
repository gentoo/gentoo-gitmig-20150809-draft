# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/osm2pgsql/osm2pgsql-20100413.ebuild,v 1.4 2011/03/02 20:44:45 jlec Exp $

EAPI="3"

inherit eutils autotools

DESCRIPTION="Converts OSM data to SQL and insert into PostgreSQL db"
HOMEPAGE="http://wiki.openstreetmap.org/wiki/Osm2pgsql"
SRC_URI="http://gentoo.ccss.cz/${P}svn.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	app-arch/bzip2
	dev-db/postgis
	dev-libs/libxml2:2
	sci-libs/geos
	sci-libs/proj
	sys-libs/zlib
	dev-db/postgresql-base
"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${PN}

src_prepare() {
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	dodoc README.txt || die "dodoc failed"
}
