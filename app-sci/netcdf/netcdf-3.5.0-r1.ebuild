# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/netcdf/netcdf-3.5.0-r1.ebuild,v 1.8 2003/02/13 09:23:57 vapier Exp $

DESCRIPTION="Interface for array oriented data access"
SRC_URI="ftp://ftp.unidata.ucar.edu/pub/netcdf/${P}.tar.Z"
HOMEPAGE="http://www.unidaa.ucar.edu/packages/netcdf/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"

S=${WORKDIR}/${P}/src

src_compile() {
	export CPPFLAGS=-Df2cFortran
	econf
	make || die
	make test || die
}

src_install() {
	dodir /usr/{lib,share}
	einstall MANDIR=${D}/usr/share/man
	dodoc COMPATIBILITY COPYRIGHT MANIFEST README RELEASE_NOTES VERSION
	dohtml -r .
}
