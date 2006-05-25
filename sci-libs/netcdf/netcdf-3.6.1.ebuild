# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/netcdf/netcdf-3.6.1.ebuild,v 1.2 2006/05/25 20:30:08 nerdboy Exp $

inherit fortran eutils

DESCRIPTION="Scientific library and interface for array oriented data access"
SRC_URI="ftp://ftp.unidata.ucar.edu/pub/netcdf/${P}.tar.gz"
HOMEPAGE="http://my.unidata.ucar.edu/content/software/netcdf/index.html"

LICENSE="UCAR-Unidata"
SLOT="0"
IUSE="fortran"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

S="${WORKDIR}/${P}/src"

fortran_pkg_setup() {
	if use fortran ; then
		FORTRAN="g77 gfortran pgf90"
		need_fortran "g77 gfortran pgf90"
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
	    if [ ${FORTRANC} == gfortran -o ${FORTRANC} == pgf90 ] ; then
		myconf="${myconf} CPPFLAGS=-DpgiFortran"
	    else
		myconf="${myconf} CPPFLAGS=-Df2cFortran"
	    fi
	fi

	econf ${myconf} || die "econf failed"
	make || die "make failed"
	make test || die "make test failed"
}

src_install() {
	dodir /usr/{lib,share} /usr/share/man/man3
	einstall MANDIR=${D}usr/share/man || die "Failed to install man pages"
	if use fortran ; then
	    dodir /usr/share/man/man3f
	    mv ${D}usr/share/man/man3/netcdf.3f ${D}usr/share/man/man3f/ \
		|| die "Failed to move man page"
	    dosed "s:NETCDF 3:NETCDF 3F:g" /usr/share/man/man3f/netcdf.3f \
		|| die "dosed failed"
	    if [ ${FORTRANC} == gfortran -o ${FORTRANC} == pgf90 ] ; then
		dodir /usr/share/man/man3f90
		mv ${D}usr/share/man/man3/netcdf.3f90 ${D}usr/share/man/man3f90/ \
		    || die "Failed to move man page"
	    fi
	    dodoc fortran/cfortran.doc || die "Failed to install fortran docs"
	fi
	dodoc COPYRIGHT MANIFEST README RELEASE_NOTES VERSION \
		|| die "Failed to install docs"
}
