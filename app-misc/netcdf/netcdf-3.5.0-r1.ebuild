# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Tod M. Neidt <tneidt@fidnet.com>
# $Header: /var/cvsroot/gentoo-x86/app-misc/netcdf/netcdf-3.5.0-r1.ebuild,v 1.2 2002/04/28 02:37:31 seemant Exp $

S=${WORKDIR}/${P}/src
DESCRIPTION="Interface for array oriented data access"

#Note orig source archive does not have version # in filename
#SRC_URI="ftp://ftp.unidata.ucar.edu/pub/netcdf/${PN}.tar.Z"
#but most of the mirrors do.
SRC_URI="ftp://ftp.unidata.ucar.edu/pub/netcdf/${P}.tar.Z"

HOMEPAGE="http://www.unidaa.ucar.edu/packages/netcdf/"

DEPEND="virtual/glibc"

src_compile() {
	export CPPFLAGS=-Df2cFortran
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man || die

	emake || die

	make test || die
}

src_install() {
	dodir /usr/{lib,share}

	make prefix=${D}/usr \
		MANDIR=${D}/usr/share/man \
		install || die

	dodoc COMPATIBILITY COPYRIGHT INSTALL.html MANIFEST
	dodoc README RELEASE_NOTES VERSION
}
