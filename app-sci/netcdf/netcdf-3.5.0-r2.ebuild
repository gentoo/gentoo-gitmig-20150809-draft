# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/netcdf/netcdf-3.5.0-r2.ebuild,v 1.7 2004/03/10 08:20:41 phosphan Exp $

DESCRIPTION="Scientific library and interface for array oriented data access"
SRC_URI="ftp://ftp.unidata.ucar.edu/pub/netcdf/${P}.tar.Z"
HOMEPAGE="http://www.unidata.ucar.edu/packages/netcdf/"

LICENSE="UCAR-Unidata"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~mips ~hppa"

S=${WORKDIR}/${P}/src

src_unpack() {
	unpack ${A}
	cd ${S}
	# welcome to ANSI C++ coding with sed
	sed \
		-e 's/iostream\.h/iostream/g' \
		-e 's/cout/std::cout/g' \
		-e 's/^extern "C".*//g' -i configure || die

	cd cxx && epatch ${FILESDIR}/gcc3-gentoo.patch
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
