# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/openstreetmap-icons/openstreetmap-icons-20090616.ebuild,v 1.3 2009/06/25 20:20:57 tupone Exp $

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
	dev-perl/File-Slurp"
RDEPEND=""

S=${WORKDIR}/${P}/map-icons

src_compile() {
	cmake-utils_src_compile
	cp icons.* ${CMAKE_BUILD_DIR}
	cd ${CMAKE_BUILD_DIR}
	perl "${S}"/tools/create_geoinfo-db.pl --lang=en --source=icons.xml
	perl "${S}"/tools/create_geoinfo-db.pl --lang=de --source=icons.xml
}

# tar.bz2 generated extracting files from
# http://svn.openstreetmap.org/applications/share/map-icons
src_install() {
	insinto /usr/share/icons/map-icons
	cd ../map-icons_build
	doins -r icons.* geoinfo.* *.small *.big || die "Install failed"
}
