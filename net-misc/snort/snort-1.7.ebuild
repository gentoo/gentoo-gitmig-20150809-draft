# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger achim@gentoo.org
# $Header: /var/cvsroot/gentoo-x86/net-misc/snort/snort-1.7.ebuild,v 1.1 2001/05/10 06:12:37 ryan Exp $

#P=
A="${P}.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="Libpcap packet sniffer/logger/lightweight IDS"
SRC_URI="http://www.snort.org/Files/${A}"
HOMEPAGE="http://www.snort.org"

DEPEND=">=net-libs/libpcap-0.5.2
        mysql? ( >=dev-db/mysql-3.23.26 )
	ssl? ( >=dev-libs/openssl-0.9.6a )"

src_compile() {

    local myconf
    if [ `use mysql` ]
    then
	myconf="--with-mysql-includes=/usr/include/mysql \
		--with-mysql-libraries=/usr/lib/mysql"
    else
	myconf="--without-mysql"
    fi
    if [ `use ssl` ]
    then
	myconf="$myconf --with-openssl"
    else
	myconf="$myconf --without-openssl"
    fi
    try ./configure --prefix=/usr --host=${CHOST} \
         --enable-smbalerts --enable-pthreads \
	 $myconf
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


