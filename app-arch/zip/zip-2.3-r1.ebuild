# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-arch/zip/zip-2.3-r1.ebuild,v 1.6 2002/07/16 00:54:22 owen Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Info ZIP"
SRC_URI="http://www.ibiblio.org/pub/Linux/distributions/gentoo/distfiles/${PN}23.tar.gz"
HOMEPAGE="ftp://ftp.freesoftware.com/pub/infozip/Zip.html"
LICENSE="Info-ZIP"

DEPEND="virtual/glibc"
KEYWORDS="x86 ppc"

src_unpack() {

  unpack ${A}
  cd ${S}/unix
  cp Makefile Makefile.orig
  sed -e "s:-O2:${CFLAGS}:" Makefile.orig > Makefile

}
src_compile() {

    try make -f unix/Makefile generic_gcc

}

src_install () {

    dobin zip zipcloak zipnote zipsplit
    doman man/zip.1

    dodoc BUGS CHANGES LICENSE MANUAL README TODO WHATSNEW WHERE

}

