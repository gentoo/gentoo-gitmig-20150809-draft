# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SNMP_Session/SNMP_Session-0.83.ebuild,v 1.1 2001/02/16 20:01:14 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A SNMP Perl Module"
SRC_URI="ftp://ftp.switch.ch/software/sources/network/snmp/perl/${A}"
HOMEPAGE="http://www.switch.ch/misc/leinen/snmp/perl/"

DEPEND=">=sys-devel/perl-5"

src_compile() {
    cd ${S}
    perl Makefile.PL
    try make 
}

src_install () {
    cd ${S}
    try make PREFIX=${D}/usr install
    dodoc MANIFEST README README.SNMP_util index.html
}
