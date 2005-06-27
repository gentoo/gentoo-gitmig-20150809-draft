# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cfitsio/cfitsio-2.510.ebuild,v 1.2 2005/06/27 00:03:03 nerdboy Exp $

inherit eutils

IUSE="doc"

DESCRIPTION="C and Fortran library for manipulating FITS files"
HOMEPAGE="http://heasarc.gsfc.nasa.gov/docs/software/fitsio/fitsio.html"
SRC_URI="ftp://heasarc.gsfc.nasa.gov/software/fitsio/c/${PN}${PV//.}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~hppa ~alpha ~amd64 ppc ~ppc64"

DEPEND="virtual/libc"

S=${WORKDIR}/${PN}

src_compile() {
	econf --prefix=${D}usr || die "econf failed"
	sed -i -e "s:CFITSIO_LIB = /usr/lib:CFITSIO_LIB = ${D}usr/lib:g" Makefile
	sed -i -e "s:CFITSIO_INCLUDE =	/usr/include:CFITSIO_INCLUDE = ${D}usr/include:g" Makefile
	emake || die "make failed"
	make shared fitscopy imcopy listhead
}

src_install () {
	dodir /usr/lib /usr/include
	einstall || die "einstall failed"
	dobin fitscopy imcopy listhead
	dodoc changes.txt README Licence.txt

	if use doc; then
		dodoc *.ps cookbook.*
	fi
}
