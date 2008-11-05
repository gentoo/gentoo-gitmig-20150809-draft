# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/wcslib/wcslib-4.3.ebuild,v 1.2 2008/11/05 21:56:07 bicatali Exp $

inherit fortran eutils

DESCRIPTION="Astronomical World Coordinate System transformations library"
HOMEPAGE="http://www.atnf.csiro.au/people/mcalabre/WCS/"
SRC_URI="ftp://ftp.atnf.csiro.au/pub/software/${PN}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
DEPEND="sci-libs/pgplot
	sci-libs/cfitsio"

FORTRAN="gfortran ifc g77"

src_install () {
	# make install from makefile is buggy

	dobin utils/{HPXcvt,fitshdr,wcsgrid} || die "dobin failed"

	dolib.a C/libwcs-${PV}.a pgsbox/libpgsbox-${PV}.a || die
	dolib.so C/libwcs.so.${PV} || die
	dosym libwcs.so.${PV} /usr/$(get_libdir)/libwcs.so
	dosym libwcs-${PV}.a /usr/$(get_libdir)/libwcs.a
	dosym libpgsbox-${PV}.a /usr/$(get_libdir)/libpgsbox.a

	insinto /usr/include/${P}
	doins pgsbox/*.h C/*.h Fortran/*inc || die "headers install failed"
	dosym ${P} /usr/include/${PN}

	dodoc README
	newdoc C/CHANGES CHANGES_C
	newdoc Fortran/CHANGES CHANGES_FORTRAN
	newdoc pgsbox/CHANGES CHANGES_PGSBOX
}
