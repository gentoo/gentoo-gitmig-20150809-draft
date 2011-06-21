# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/raster3d/raster3d-2.7c.ebuild,v 1.14 2011/06/21 15:57:37 jlec Exp $

inherit fortran-2 toolchain-funcs

NAME="Raster3D"

DESCRIPTION="Generation high quality raster images of proteins or other molecules"
HOMEPAGE="http://www.bmsc.washington.edu/raster3d/raster3d.html"
SRC_URI="http://www.bmsc.washington.edu/${PN}/${NAME}_${PV}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="ppc x86"
IUSE=""

RDEPEND="
	virtual/fortran

	virtual/jpeg
	media-libs/libpng
	media-libs/tiff"
DEPEND="${RDEPEND}
	x11-misc/imake"

S="${WORKDIR}/${NAME}_${PV}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/raster3d-gcc-4.1-gentoo.patch
}

src_compile() {
	# fix Makefile to honor user's CFLAGS/FFLAGS
	sed -e "s:gcc:$(tc-getCC):" \
		-e "s:g77:$(tc-getFC):" \
		-e "s:-g -m486 -w:${CFLAGS}:" \
		-e "s:-g -O -w -malign-double:${FFLAGS} -w:" \
		-i Makefile || die "Failed to patch makefile"

	sed -e "s:prefix  = /usr/local:prefix  = /usr:" \
		-i Makefile.template || \
		die "Failed to patch makefile.template"

	make linux || die "Failed to make linux target."
	make all || die "Failed to make all target."
}

src_install() {
	emake prefix="${D}"/usr \
			bindir="${D}"/usr/bin \
			datadir="${D}"/usr/share/Raster3D/materials \
			mandir="${D}"/usr/share/man/man1 \
			htmldir="${D}"/usr/share/Raster3D/html \
			examdir="${D}"/usr/share/Raster3D/examples \
			install || die "Failed to install application."

	dodir /etc/env.d
	echo -e "R3D_LIB=/usr/share/${NAME}/materials" > \
		"${D}"/etc/env.d/10raster3d || \
		die "Failed to install env file."
}
