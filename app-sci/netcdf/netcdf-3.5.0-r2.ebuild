# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/netcdf/netcdf-3.5.0-r2.ebuild,v 1.4 2003/12/17 23:01:19 mholzer Exp $

DESCRIPTION="Interface for array oriented data access"
SRC_URI="ftp://ftp.unidata.ucar.edu/pub/netcdf/${P}.tar.Z"
HOMEPAGE="http://www.unidata.ucar.edu/packages/netcdf/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"

S=${WORKDIR}/${P}/src

src_unpack() {
	unpack ${A}
	cd ${S}
	# welcome to ANSI C++ coding with sed
	cp configure configure~ && sed \
		-e 's/iostream\.h/iostream/g' \
		-e 's/cout/std::cout/g' \
		-e 's/^extern "C".*//g' <configure~ >configure || die

	cd cxx && patch -p1 <${FILESDIR}/gcc3-gentoo.patch || die
}

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
