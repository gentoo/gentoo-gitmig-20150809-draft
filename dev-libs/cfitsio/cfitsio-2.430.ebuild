# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cfitsio/cfitsio-2.430.ebuild,v 1.2 2003/02/13 10:34:43 vapier Exp $

IUSE=""

A="${PN}2430.tar.gz"
S="${WORKDIR}/${PN}"
DESCRIPTION="C and Fortran library for reading and writing files in FITS data format"
SRC_URI="ftp://heasarc.gsfc.nasa.gov/software/fitsio/c/${A}"
HOMEPAGE="http://heasarc.gsfc.nasa.gov/docs/software/fitsio/fitsio.html"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86"

DEPEND="virtual/glibc"

#src_unpack() {
#	unpack "${PN}2430.tar.gz"
#	cd "${S}"
#}

src_compile() {
#	./configure \
#		--host=${CHOST} \
#		--prefix=/usr \
#		--infodir=/usr/share/info \
#		--mandir=/usr/share/man || die "./configure failed"
	econf || die "./configure failed"
	emake || die
}

src_install () {

	cd ${S}

	mkdir -p ${D}usr/lib
	mkdir -p ${D}usr/include

	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		FTOOLS_LIB=${D}usr/lib \
		FTOOLS_INCLUDE=${D}usr/include \
		install || die

	dodoc changes.txt README
}
