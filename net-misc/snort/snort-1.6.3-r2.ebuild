# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /home/cvsroot/gentoo-x86/net-misc/snort/snort-1.6.3.ebuild,v 1.3 
2000/11/13 20:26:47 achim Exp $

#P=
A="${P}.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="Libpcap packet sniffer/logger/lightweight IDS"
SRC_URI="http://www.snort.org/Files/${A}"
HOMEPAGE="http://www.snort.org"

DEPEND=">=net-libs/libpcap-0.5.2
        >=dev-db/mysql-3.23.26"

RDEPEND=">=dev-db/mysql-3.23.26"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST} \
         --enable-smbalerts --enable-pthreads \
         --with-mysql-includes=/usr/include/mysql \
        --with-mysql-libraries=/usr/lib/mysql/lib
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    insinto /usr/lib/snort/bin
    doins contrib/create_mysql contrib/*.pl contrib/snortlog
    dodoc AUTHORS BUGS ChangeLog COPYING CREDITS NEWS README.*
    dodoc RULES.SAMPLE USAGE contrib/pgsql.php3
}


