# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SGMLSpm/SGMLSpm-1.03.ebuild,v 1.1 2000/10/19 16:01:59 achim Exp $

A=${PN}-${PV}ii.tar.gz
S=${WORKDIR}/${PN}
DESCRIPTION="Perl library for parsing the output of nsgmls"
SRC_URI="ftp://cpan.perl.org/pub/perl/CPAN/modules/by-module/SGMLS/${A}"
HOMEPAGE="ftp://cpan.perl.org/pub/perl/CPAN/modules/by-module/SGMLS/${PN}-${PV}ii.readme"


src_unpack() {

  unpack ${A}
  cp ${FILESDIR}/Makefile ${S}

}
src_compile() {

    cd ${S}

}

src_install () {

    cd ${S}
    dodir /usr/lib/perl5/site_perl/5.6.0/
    dodir /usr/bin
    dodoc BUGS DOC README TODO COPYING ChangeLog
    try make

}

