# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/LockFile-Simple/LockFile-Simple-0.2.5.ebuild,v 1.1 2001/01/24 07:05:18 jerry Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="File locking module for Perl"
SRC_URI="http://www.cpan.org/modules/by-module/LockFile/${A}"
HOMEPAGE="http://www.cpan.org/modules/by-module/LockFile/${P}.readme"

DEPEND=">=sys-devel/perl-5"

src_compile() {
    cd ${S}
    perl Makefile.PL
    try make
    try make test
}

src_install () {
    cd ${S}
    try make PREFIX=${D}/usr install
    dodoc ChangeLog MANIFEST README
}
