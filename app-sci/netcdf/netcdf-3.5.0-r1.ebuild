# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-sci/netcdf/netcdf-3.5.0-r1.ebuild,v 1.5 2002/09/15 04:58:16 seemant Exp $

S=${WORKDIR}/${P}/src
DESCRIPTION="Interface for array oriented data access"
SRC_URI="ftp://ftp.unidata.ucar.edu/pub/netcdf/${P}.tar.Z"
HOMEPAGE="http://www.unidaa.ucar.edu/packages/netcdf/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"

src_compile() {
	export CPPFLAGS=-Df2cFortran
	econf || die
	make || die
	make test || die
}

src_install() {
	dodir /usr/{lib,share}

	einstall \
		MANDIR=${D}/usr/share/man || die

	dodoc COMPATIBILITY COPYRIGHT MANIFEST README RELEASE_NOTES VERSION
	dohtml -r .
}
