# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger achim@gentoo.org
# $Header: /var/cvsroot/gentoo-x86/net-misc/snort/snort-1.8.3.ebuild,v 1.1 2002/01/08 11:14:40 blocke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Libpcap packet sniffer/logger/lightweight IDS"
SRC_URI="http://www.snort.org/releases/${P}.tar.gz"
HOMEPAGE="http://www.snort.org"

DEPEND="virtual/glibc >=net-libs/libpcap-0.5.2
        mysql? ( >=dev-db/mysql-3.23.26 )
	ssl? ( >=dev-libs/openssl-0.9.6a )"

RDEPEND="virtual/glibc sys-devel/perl
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
	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--host=${CHOST} \
		--enable-smbalerts \
		--enable-pthreads \
		--without-odbc \
		--without-postgresql \
		--without-oracle \
		$myconf || die
		
	make || die
}

src_install() {

	make DESTDIR=${D} install || die
	insinto /usr/lib/snort/bin
	
	doins contrib/create_mysql contrib/*.pl contrib/snortlog
	dodoc AUTHORS BUGS ChangeLog COPYING CREDITS NEWS README.*
	dodoc RULES.SAMPLE USAGE contrib/pgsql.php3
	
	insinto /etc/snort
	doins ${FILESDIR}/snort.conf
	
	insinto /usr/lib/snort
	doins *lib
	
	exeinto /etc/init.d
	doexe ${FILESDIR}/snort
	insinfo /etc/conf.d
	newins ${FILESDIR}/snort.confd snort
}

pkg_postint() {

	groupadd snort
	useradd -s /dev/null -g snort -s /bin/false snort
}

