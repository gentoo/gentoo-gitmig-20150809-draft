# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-sci/netcdf/netcdf-3.5.0-r1.ebuild,v 1.3 2002/07/18 04:09:19 george Exp $

S=${WORKDIR}/${P}/src
DESCRIPTION="Interface for array oriented data access"

#Note orig source archive does not have version # in filename
#SRC_URI="ftp://ftp.unidata.ucar.edu/pub/netcdf/${PN}.tar.Z"
#but most of the mirrors do.
SRC_URI="ftp://ftp.unidata.ucar.edu/pub/netcdf/${P}.tar.Z"
HOMEPAGE="http://www.unidaa.ucar.edu/packages/netcdf/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc"

PROVIDE="app-misc/netcdf"

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
