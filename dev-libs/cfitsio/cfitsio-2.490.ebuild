# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cfitsio/cfitsio-2.490.ebuild,v 1.1 2004/07/26 23:43:14 ribosome Exp $

DESCRIPTION="C and Fortran library for manipulating FITS files"
HOMEPAGE="http://heasarc.gsfc.nasa.gov/docs/software/fitsio/fitsio.html"
SRC_URI="ftp://heasarc.gsfc.nasa.gov/software/fitsio/c/${PN}${PV//.}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/glibc"

S=${WORKDIR}/${PN}

src_compile() {
	econf || die
	emake || die
}

src_install () {
	dodir /usr/lib /usr/include

	sed -i -e "s:CFITSIO_LIB =	/usr/lib:CFITSIO_LIB = ${D}/usr/lib:g" \
	-e "s:CFITSIO_INCLUDE =	/usr/include:CFITSIO_INCLUDE = ${D}/usr/include:g" \
	Makefile

	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		FTOOLS_LIB=${D}usr/lib \
		FTOOLS_INCLUDE=${D}usr/include \
		install || die

	dodoc changes.txt README
}
