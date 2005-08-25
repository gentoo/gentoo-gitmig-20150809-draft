# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/netcdf/netcdf-3.6.0-r1.ebuild,v 1.8 2005/08/25 13:10:07 agriffis Exp $

inherit eutils

MY_PV=${PV}-p1

DESCRIPTION="Scientific library and interface for array oriented data access"
SRC_URI="ftp://ftp.unidata.ucar.edu/pub/netcdf/${PN}-${MY_PV}.tar.gz"
HOMEPAGE="http://my.unidata.ucar.edu/content/software/netcdf/index.html"

LICENSE="UCAR-Unidata"
SLOT="0"
IUSE=""
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ~ppc64 sparc x86"

S=${WORKDIR}/${PN}-${MY_PV}/src

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
