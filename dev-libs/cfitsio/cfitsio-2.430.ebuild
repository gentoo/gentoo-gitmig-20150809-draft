# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cfitsio/cfitsio-2.430.ebuild,v 1.7 2004/07/14 14:07:01 agriffis Exp $

DESCRIPTION="C and Fortran library for reading and writing files in FITS data format"
HOMEPAGE="http://heasarc.gsfc.nasa.gov/docs/software/fitsio/fitsio.html"
SRC_URI="ftp://heasarc.gsfc.nasa.gov/software/fitsio/c/${PN}-${PV//.}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${PN}

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install () {
	dodir /usr/lib /usr/include

	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		FTOOLS_LIB=${D}usr/lib \
		FTOOLS_INCLUDE=${D}usr/include \
		install || die

	dodoc changes.txt README
}
