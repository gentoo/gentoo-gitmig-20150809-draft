# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/osm2pgsql/osm2pgsql-99999999.ebuild,v 1.1 2010/04/27 09:22:19 scarabeus Exp $

EAPI="3"

inherit eutils autotools subversion

ESVN_REPO_URI="http://svn.openstreetmap.org/applications/utils/export/${PN}/"
ESVN_PROJECT="${PN}"

DESCRIPTION="Converts OSM data to SQL and insert into PostgreSQL db"
HOMEPAGE="http://wiki.openstreetmap.org/wiki/Osm2pgsql"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	app-arch/bzip2
	dev-db/postgis
	dev-libs/libxml2
	sci-libs/geos
	sci-libs/proj
	sys-libs/zlib
	virtual/postgresql-base
"
RDEPEND="${DEPEND}"

src_prepare() {
	esvn_clean
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	dodoc README.txt || die "dodoc failed"
}
