# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PDL/PDL-2.1.1.ebuild,v 1.4 2000/11/01 06:27:09 achim Exp $

P=PDL-2.1.1
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="PDL Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-module/PDL/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/PDL/${P}.readme"

DEPEND=">=sys-devel/perl-5
	>=sys-libs/glibc-2.1.3
	>=sys-libs/gpm-1.19.3
	>=sys-libs/ncurses-5.1
	>=dev-perl/ExtUtils-F77-1.13"

src_unpack() {
  unpack ${A}
  cd ${S}
  cp perldl.conf perldl.conf.orig
  sed -e "s:WITH_3D => undef:WITH_3D => 0:" perldl.conf.orig > perldl.conf
}
src_compile() {

    cd ${S}
    perl Makefile.PL $PERLINSTALL
    try make
    try make test

}

src_install () {

    cd ${S}
    try make install
    dodoc COPYING Changes DEPENDENCIES DEVELOPMENT README MANIFEST*
    dodoc Release_Notes TODO 
}






