# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PDL/PDL-2.1.1.ebuild,v 1.1 2000/08/28 10:37:27 achim Exp $

P=PDL-2.1.1
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="PDL Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-module/PDL/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/PDL/${P}.readme"

src_unpack() {
  unpack ${A}
  cd ${S}
  cp perldl.conf perldl.conf.orig
  sed -e "s:WITH_3D => undef:WITH_3D => 0:" perldl.conf.orig > perldl.conf
}
src_compile() {

    cd ${S}
    perl Makefile.PL $PERLINSTALL
    make
    make test

}

src_install () {

    cd ${S}
    make install
    prepman
    dodoc COPYING Changes DEPENDENCIES DEVELOPMENT README MANIFEST*
    dodoc Release_Notes TODO 
}






