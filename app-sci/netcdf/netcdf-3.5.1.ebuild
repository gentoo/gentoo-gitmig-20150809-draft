# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/netcdf/netcdf-3.5.1.ebuild,v 1.5 2004/12/11 19:04:05 kloeri Exp $

inherit eutils

DESCRIPTION="Scientific library and interface for array oriented data access"
SRC_URI="ftp://ftp.unidata.ucar.edu/pub/netcdf/${P}.tar.Z"
HOMEPAGE="http://www.unidata.ucar.edu/packages/netcdf/"

LICENSE="UCAR-Unidata"
SLOT="0"
IUSE=""
KEYWORDS="x86 sparc ~amd64 alpha ~ia64 ~ppc ~mips ~hppa"

S=${WORKDIR}/${P}/src

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/fPIC.patch || die "fPIC patch failed"
}

src_compile() {
	export CPPFLAGS=-Df2cFortran
	econf || die "econf failed"
	make || die "make failed"
	make test || die "make test failed"
}

src_install() {
	dodir /usr/{lib,share} /usr/share/man/man3 /usr/share/man/man3f
	einstall MANDIR=${D}/usr/share/man
	mv ${D}/usr/share/man/man3/netcdf.3f ${D}/usr/share/man/man3f/.
	dodoc COMPATIBILITY COPYRIGHT MANIFEST README RELEASE_NOTES VERSION fortran/cfortran.doc
	dohtml -r .
}
