# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SNMP_Session/SNMP_Session-0.80.ebuild,v 1.1 2000/11/06 19:36:48 jerry Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
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
