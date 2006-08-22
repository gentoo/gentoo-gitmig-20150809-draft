# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/netcdf/netcdf-3.6.1.ebuild,v 1.13 2006/08/22 14:02:20 geoman Exp $

inherit fortran eutils toolchain-funcs

DESCRIPTION="Scientific library and interface for array oriented data access"
SRC_URI="ftp://ftp.unidata.ucar.edu/pub/netcdf/${P}.tar.gz"
HOMEPAGE="http://my.unidata.ucar.edu/content/software/netcdf/index.html"

LICENSE="UCAR-Unidata"
SLOT="0"
IUSE="fortran"
KEYWORDS="~alpha amd64 hppa ia64 mips ppc ppc64 sparc x86"

S="${WORKDIR}/${P}/src"

pkg_setup() {
	if use fortran ; then
	    need_fortran "gfortran ifc g77"
#	    fortran_pkg_setup
	else
	    FORTRAN=""
	fi
}
src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}"/fPIC.patch || die "fPIC patch failed"
}

src_compile() {
	local myconf

	if use fortran ; then
	    if [ ${FORTRANC} == gfortran ] ; then
		myconf="${myconf} CPPFLAGS=-DpgiFortran"
	    else
		myconf="${myconf} CPPFLAGS=-Df2cFortran"
	    fi
	fi

	econf ${myconf} || die "econf failed"

	make || die "make failed"
}

src_test() {
	make test || die "make test failed"
}

src_install() {
	dodir /usr/{lib,share} /usr/share/man/man3

	einstall MANDIR=${D}usr/share/man || die "einstall failed"

	if test -f ${D}usr/share/man/man3/netcdf.3f ; then
	    dodir /usr/share/man/man3f
	    mv ${D}usr/share/man/man3/netcdf.3f ${D}usr/share/man/man3f/ \
		|| die "Failed to move f77 man page"
	    dosed "s:NETCDF 3:NETCDF 3F:g" /usr/share/man/man3f/netcdf.3f \
		|| die "dosed failed"
	    if test -f ${D}usr/share/man/man3/netcdf.3f90 ; then
		dodir /usr/share/man/man3f90
		mv ${D}usr/share/man/man3/netcdf.3f90 ${D}usr/share/man/man3f90/ \
		    || die "Failed to move f90 man page"
	    fi
	    dodoc fortran/cfortran.doc || die "Failed to install fortran docs"
	fi

	dodoc COPYRIGHT README RELEASE_NOTES VERSION \
		|| die "Failed to install docs"
}
