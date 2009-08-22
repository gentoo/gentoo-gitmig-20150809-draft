# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/openstreetmap-icons/openstreetmap-icons-20090616.ebuild,v 1.6 2009/08/22 23:22:34 nerdboy Exp $

EAPI=2

inherit cmake-utils

DESCRIPTION="openstreetmap icons"
HOMEPAGE="http://www.openstreetmap.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-perl/ImageInfo
	media-gfx/imagemagick[perl]
	dev-perl/File-Slurp
	dev-perl/DBD-SQLite
	dev-perl/XML-Twig"

RDEPEND=""

S=${WORKDIR}/${P}/map-icons

src_compile() {
	cmake-utils_src_compile
	cp icons.* ${CMAKE_BUILD_DIR}
	cd ${CMAKE_BUILD_DIR}
	perl "${S}"/tools/create_geoinfo-db.pl --lang=en --source=icons.xml \
	    || die "create en geoinfo-db failed"
	perl "${S}"/tools/create_geoinfo-db.pl --lang=de --source=icons.xml \
	    || die "create de geoinfo-db failed"
}

# tar.bz2 generated extracting files from
# http://svn.openstreetmap.org/applications/share/map-icons
src_install() {
	insinto /usr/share/osm
	cd ../map-icons_build
	doins -r icons.* *.small *.big || die "Install icons failed"
	doins geoinfo.* || die "Install db failed"
}

pkg_postinst() {
	elog
	elog "Non-fatal errors are expected on a handful of .svg files,"
	elog "and the cause is currently unknown.  File a bug only if"
	elog "you have a runtime problem and/or more useful information."
	elog
	elog "This version also installs the icons in a more appropriate"
	elog "location, so if you have an existing gpsdrive install, you"
	elog "should probably update your ~/.gpsdrive/gpsdriverc file"
	elog "and change the path to the geoinfofile to reflect this:"
	elog "   geoinfofile = /usr/share/osm/geoinfo.db"
	elog
}
