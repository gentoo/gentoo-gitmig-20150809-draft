# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Geert Bevin <gbevin@theleaf.be>
# $Header: /var/cvsroot/gentoo-x86/app-editors/nedit/nedit-5.2.ebuild,v 1.1 2001/12/05 02:01:46 gbevin Exp $

S=${WORKDIR}/${P}
DESCRIPTION="NEdit is a multi-purpose text editor for the X Window System"
SRC_URI="ftp://ftp.nedit.org/pub/v5_2/${P}-src.tar.gz"
HOMEPAGE="http://nedit.org/"

DEPEND="virtual/glibc
	>=dev-util/yacc-1.9.1
	>=x11-libs/openmotif-2.1.30"

RDEPEND="virtual/glibc
	>=x11-libs/openmotif-2.1.30"
	
src_unpack() {

  unpack ${A}
  cd ${S}/makefiles
  cp Makefile.linux Makefile.orig
  sed -e "s:-O:${CFLAGS}:" Makefile.orig > Makefile.linux

}

src_compile() {

    try make linux

}

src_install () {

    into /usr
    dobin source/nc source/nedit
    newman doc/nedit.man nedit.1
    newman doc/nc.man nc.1
    dodoc README ReleaseNotes doc/faq* doc/nedit.doc doc/README.FAQ doc/NEdit.ad

}

