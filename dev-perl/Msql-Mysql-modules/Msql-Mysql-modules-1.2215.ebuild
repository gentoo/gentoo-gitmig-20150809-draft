# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Msql-Mysql-modules/Msql-Mysql-modules-1.2215.ebuild,v 1.2 2001/01/27 14:41:33 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="The Perl MySQL Module"
SRC_URI="http://www.cpan.org/modules/by-module/Msql/${A}"
HOMEPAGE="http://www.cpan.org/modules/by-module/Msql/${P}.readme"


DEPEND=">=dev-perl/DBI-1.14
        >=dev-perl/Data-ShowTable-3.3
	>=dev-db/mysql-3.23.30
        >=sys-devel/perl-5"

src_compile() {
    cd ${S}
    perl Makefile.PL --mysql-install --nomsql-install --nomsql1-install \
        --mysql-incdir=/usr/include/mysql --mysql-libdir=/usr/lib \
        --noprompt
    try make
    #try make test
}

src_install () {
    cd ${S}
    try make PREFIX=${D}/usr install
    dodoc ChangeLog MANIFEST README ToDo
}



