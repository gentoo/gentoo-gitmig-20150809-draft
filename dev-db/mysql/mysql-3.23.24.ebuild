# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql/mysql-3.23.24.ebuild,v 1.2 2000/09/15 20:08:47 drobbins Exp $

P=mysql-3.23.24-beta
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The MySQL Database"
SRC_URI="http://www.mysql.com/Downloads/MySQL-3.23/${A}"
HOMEPAGE="http://www.mysql.com/"


src_compile() {
        if [ "$PLATFORM" = "i686-pc-linux-gnu" ]
	then
	    export CFLAGS="-mpentium"
	    export CXXFLAGS="-mpentium"
	fi
	# Patch for qmail-mysql                           
	cd ${S}/include
	cp nisam.h nisam.h.orig
	sed -e "s/define N_MAX_KEY_LENGTH 256/define N_MAX_KEY_LENGTH 500/" nisam.h.orig > nisam.h

	cd ${S}
	CXX=gcc ./configure --prefix=/usr --host=${CHOST} \
	--enable-shared \
	--enable-static \
	--enable-assembler \
	--libdir=/usr/lib \
	--libexecdir=/usr/sbin \
	--sysconfdir=/etc/mysql \
	--localstatedir=/var/mysql \
	--infodir=/usr/info \
	--mandir=/usr/man \
	--without-debug \
	--with-mysql-user=mysql
	try make benchdir=/usr/share/mysql-bench
}

src_install() {

	cd ${S}
	
	# Install MySQL

	try make install prefix=${D}/usr \
		libdir=${D}/usr/lib \
		libexecdir=${D}/usr/sbin \
		sysconfdir=${D}/etc/mysql \
		localstatedir=${D}/var/mysql \
		infodir=${D}/usr/info \
		mandir=${D}/usr/man \
	 	benchdir=${D}/usr/share/mysql-bench

	prepman
	prepinfo

	# Move Client Libs
	mv ${D}/usr/lib/mysql/libmysqlclient.so* ${D}/usr/lib

	into /
	dodir /etc/mysql
	cp scripts/mysqlaccess.conf ${D}/etc/mysql
	cp ${O}/files/my.cnf ${D}/etc/mysql

	dodir /etc/rc.d/init.d
	cp ${O}/files/mysql ${D}/etc/rc.d/init.d/mysql
	
	# MySQL Docs
	
	cd ${S}
	into /usr
	dodoc INSTALL-SOURCE README MIRRORS
	cd ${S}/Docs 
	dodoc INSTALL-BINARY manual.ps manual.txt
	docinto html
	dodoc manual.html manual_toc.html
		
}

pkg_config () {

  echo "Setting up symlinks..."
  ${ROOT}/usr/sbin/rc-update add mysql

}







