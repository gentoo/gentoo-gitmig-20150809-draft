# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Tod M. Neidt <tneidt@fidnet.com>
# /home/cvsroot/gentoo-x86/app-misc/netCDF/netcdf-3.5.0.ebuild,v 1.4 2001/06/04 21:57:52 achim Exp

A=${P}.tar.Z
S=${WORKDIR}/${P}/src
DESCRIPTION="interface for array oriented data access"
#Note orig source archive does not have version #
SRC_URI="ftp://ftp.unidata.ucar.edu/pub/netcdf/"${A}
HOMEPAGE="http://www.unidaa.ucar.edu/packages/netcdf/"

DEPEND="virtual/glibc"

src_compile() {
  export CPPFLAGS=-Df2cFortran
  ./configure --prefix=/usr --mandir=/usr/share/man
  try make
  unset CPPFLAGS
  try make test
}

src_install() {
  dodir /usr/{lib,share}
  try make install prefix=${D}/usr MANDIR=${D}/usr/share/man
  dodoc COMPATIBILITY COPYRIGHT INSTALL.html MANIFEST
  dodoc README RELEASE_NOTES VERSION
}  
