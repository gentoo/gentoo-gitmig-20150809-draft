# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SGMLSpm/SGMLSpm-1.03.ebuild,v 1.6 2001/04/28 12:27:43 achim Exp $

A=${PN}-${PV}ii.tar.gz
S=${WORKDIR}/${PN}
DESCRIPTION="Perl library for parsing the output of nsgmls"
SRC_URI="ftp://cpan.perl.org/pub/perl/CPAN/modules/by-module/SGMLS/${A}"
HOMEPAGE="ftp://cpan.perl.org/pub/perl/CPAN/modules/by-module/SGMLS/${PN}-${PV}ii.readme"

DEPEND=">=sys-devel/perl-5"

src_unpack() {

  unpack ${A}
  cp ${FILESDIR}/${P}-Makefile ${S}/Makefile

}
src_compile() {

    cd ${S}

}

src_install () {

    cd ${S}
    dodir /usr/lib/perl5/site_perl/5.6.1
    dodir /usr/bin
    dodoc BUGS DOC README TODO COPYING ChangeLog
    try make
    cd ${D}/usr/lib/perl5
    mv SGMLS.pm site_perl/5.6.1/SGMLS.pm

}

