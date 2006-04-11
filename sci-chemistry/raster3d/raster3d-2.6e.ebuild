# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/raster3d/raster3d-2.6e.ebuild,v 1.2 2006/04/11 04:50:05 markusle Exp $

Name="Raster3D"
S="${WORKDIR}/${Name}_${PV}"
DESCRIPTION="a set of tools for generating high quality raster images of proteins or other molecules"
HOMEPAGE="http://www.bmsc.washington.edu/raster3d/raster3d.html"
SRC_URI="http://www.bmsc.washington.edu/${PN}/${Name}_${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
IUSE=""
KEYWORDS="x86"

RDEPEND="media-libs/jpeg
	media-libs/libpng
	media-libs/tiff"

DEPEND="${RDEPEND}
	|| ( x11-misc/imake virtual/x11 )"

src_compile() {
	sed "/prefix/s/\/usr\/local/\/usr/" ${S}/Makefile.template > ${S}/Makefile.template.new
	mv ${S}/Makefile.template.new ${S}/Makefile.template

	make linux
	make all || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/Raster3D/materials
	dodir /usr/share/Raster3D/html
	dodir /usr/share/Raster3D/examples
	dodir /usr/share/man/man1

	emake \
			prefix=${D}/usr \
			bindir=${D}/usr/bin \
			datadir=${D}/usr/share/Raster3D/materials \
			mandir=${D}/usr/share/man/man1 \
			htmldir=${D}/usr/share/Raster3D/html \
			examdir=${D}/usr/share/Raster3D/examples \
			install || die

	dodir /etc/env.d
	echo -e "R3D_LIB=/usr/share/Raster3D/materials" > \
			${D}/etc/env.d/10raster3d
}
