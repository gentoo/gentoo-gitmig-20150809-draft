# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PDL/PDL-2.1.1.ebuild,v 1.6 2000/11/28 16:43:55 achim Exp $

P=PDL-2.1.1
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="PDL Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-module/PDL/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/PDL/${P}.readme"

DEPEND=">=sys-devel/perl-5
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
    perl Makefile.PL 
    try make
    make test

}

src_install () {

    cd ${S}
    try make PREFIX=${D}/usr install
    dodoc COPYING Changes DEPENDENCIES DEVELOPMENT README MANIFEST*
    dodoc Release_Notes TODO
    mv ${D}/usr/lib/perl5/site_perl/5.6.0/i686-linux-thread-multi/PDL/HtmlDocs ${D}/usr/doc/${P}/html
    mydir=${D}/usr/doc/${P}/html/PDL
    for i in ${mydir}/* ${mydir}/IO/* ${mydir}/Fit/* ${mydir}/Pod/* ${mydir}/Graphics/* 
    do
	dosed ${i/${D}}
    done
    dosed /usr/lib/perl5/site_perl/5.6.0/i686-linux-thread-multi/PDL/pdldoc.db 
}






