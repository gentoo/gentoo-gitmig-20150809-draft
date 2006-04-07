# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/netcdf/netcdf-3.6.1.ebuild,v 1.1 2006/04/07 13:57:30 markusle Exp $

inherit fortran eutils

DESCRIPTION="Scientific library and interface for array oriented data access"
SRC_URI="ftp://ftp.unidata.ucar.edu/pub/netcdf/${P}.tar.gz"
HOMEPAGE="http://my.unidata.ucar.edu/content/software/netcdf/index.html"

LICENSE="UCAR-Unidata"
SLOT="0"
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

S="${WORKDIR}/${P}/src"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}"/fPIC.patch || die "fPIC patch failed"
}

src_compile() {
	local myconf

	if [[ ${FORTRANC} == gfortran ]]; then
		myconf="${myconf} CPPFLAGS=-DpgiFortran"
	else
		myconf="${myconf} CPPFLAGS=-Df2cFortran"
	fi

	econf ${myconf} || die "econf failed"
	make || die "make failed"
	make test || die "make test failed"
}

src_install() {
	dodir /usr/{lib,share} /usr/share/man/man3 /usr/share/man/man3f
	einstall MANDIR=${D}/usr/share/man \
		|| die "Failed to install man pages"
	mv ${D}/usr/share/man/man3/netcdf.3f ${D}/usr/share/man/man3f/. \
		|| die "Failed to move man pages"

	dodoc COPYRIGHT MANIFEST README RELEASE_NOTES VERSION \
		fortran/cfortran.doc || die "Failed to install docs"
}
