# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-SNMP/Net-SNMP-3.60.ebuild,v 1.2 2000/12/15 07:29:29 jerry Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A SNMP Perl Module"
SRC_URI="http://www.cpan.org/modules/by-module/Net/${A}"
HOMEPAGE="http://www.cpan.org/modules/by-module/Net/${P}.readme"

DEPEND=">=sys-devel/perl-5
        >=dev-perl/libnet-1.0703"

src_compile() {
    cd ${WORKDIR}/Net-SNMP-3.6
    perl Makefile.PL
    try make 
    try make test
}

src_install () {
    cd ${WORKDIR}/Net-SNMP-3.6
    try make PREFIX=${D}/usr install
    dodoc Changes MANIFEST README
}
