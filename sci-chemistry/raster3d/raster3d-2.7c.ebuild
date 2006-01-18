# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/raster3d/raster3d-2.7c.ebuild,v 1.2 2006/01/18 06:55:24 spyderous Exp $

NAME="Raster3D"

DESCRIPTION="a set of tools for generating high quality raster images of proteins or other molecules"
LICENSE="as-is"
HOMEPAGE="http://www.bmsc.washington.edu/raster3d/raster3d.html"
SRC_URI="http://www.bmsc.washington.edu/${PN}/${NAME}_${PV}.tar.gz"

SLOT="0"
IUSE=""
KEYWORDS="~x86"

RDEPEND="media-libs/jpeg
	media-libs/libpng
	media-libs/tiff"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${NAME}_${PV}"

src_compile() {
	sed -e "/prefix/s/\/usr\/local/\/usr/" -i ${S}/Makefile.template || die \
		"Failed to patch makefile."

	make linux || die "Failed to make linux target."
	make all || die "Failed to make all target."
}

src_install() {
	#dodir /usr/bin
	#dodir /usr/share/Raster3D/materials
	#dodir /usr/share/Raster3D/html
	#dodir /usr/share/Raster3D/examples
	#dodir /usr/share/man/man1

	emake prefix="${D}"/usr \
			bindir="${D}"/usr/bin \
			datadir="${D}"/usr/share/Raster3D/materials \
			mandir="${D}"/usr/share/man/man1 \
			htmldir="${D}"/usr/share/Raster3D/html \
			examdir="${D}"/usr/share/Raster3D/examples \
			install || die "Failed to install application."

	#dodir /etc/env.d
	echo -e "R3D_LIB=/usr/share/${NAME}/materials" > \
		"${D}"/etc/env.d/10raster3d "Failed to install env file."
}
