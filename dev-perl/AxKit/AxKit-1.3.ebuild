# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/AxKit/AxKit-1.3.ebuild,v 1.1 2001/02/18 02:10:00 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The Apache AxKit Perl Module"
SRC_URI="http://xml.sergeant.org/download/${A}"
HOMEPAGE="http://xml.sergeant.org/"

DEPEND=">=sys-devel/perl-5"

src_unpack() {
  unpack ${A}
  cd ${S}
  cp Makefile.PL Makefile.PL.orig
  sed -e "s:0\.31_03:0.31:" Makefile.PL.orig > Makefile.PL
}

src_compile() {

    perl Makefile.PL
    try make
    try make test
}

src_install () {

    cd ${S}
    try make PREFIX=${D}/usr install
    dodoc ChangeLog MANIFEST README* TODO

}



