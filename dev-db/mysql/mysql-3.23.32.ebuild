# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql/mysql-3.23.32.ebuild,v 1.1 2001/02/08 21:03:10 achim Exp $

P=${PN}-${PV}
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The MySQL Database"
SRC_URI="ftp://mysql.valueclick.com/mysql/Downloads/MySQL-3.23/${A}
	 http://www.mysql.com/Downloads/MySQL-3.23/${A}"
HOMEPAGE="http://www.mysql.com/"

DEPEND=">=sys-apps/bash-2.04
	>=sys-apps/tcp-wrappers-7.6
	=sys-libs/db-3.2.3h
	>=sys-libs/glibc-2.1.3
	>=sys-libs/gpm-1.19.3
	>=sys-libs/ncurses-5.1"

src_unpack() {

	unpack ${A}
	cd ${S}
	cp configure configure.orig
	sed -e "s:DB_VERSION_STRING\.\*g:DB_VERSION_STRING.*h:" \
	    -e "s:-ldb:-ldb-3.2:" configure.orig > configure
	# Patch for qmail-mysql                           
	cd ${S}/include
	cp nisam.h nisam.h.orig
	sed -e "s/define N_MAX_KEY_LENGTH 256/define N_MAX_KEY_LENGTH 500/" nisam.h.orig > nisam.h
}

src_compile() {

        export CFLAGS="${CFLAGS/-O?/}"
        export CXXFLAGS="${CXXFLAGS/-O?/}"

	CXX=gcc ./configure --prefix=/usr --host=${CHOST} \
	--enable-shared \
	--enable-static \
	--enable-assembler \
	--enable-thread-safe-client \
	--with-raid \
	--with-low-memory \
	--with-libwrap \
	--without-readline \
	--libdir=/usr/lib \
	--libexecdir=/usr/sbin \
	--sysconfdir=/etc/mysql \
	--localstatedir=/var/mysql \
	--infodir=/usr/share/info \
	--mandir=/usr/share/man \
	--without-debug \
	--with-mysql-user=mysql \
	--with-berkeley-db-includes=/usr/include/db3 \
	--with-berkeley-db-libs=/usr/lib
	try make testdir=/usr/share/mysql/test benchdir=/usr/share/mysql/bench
}

src_install() {

	
	# Install MySQL

	try make install prefix=${D}/usr \
		libdir=${D}/usr/lib \
		libexecdir=${D}/usr/sbin \
		sysconfdir=${D}/etc/mysql \
		localstatedir=${D}/var/mysql \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
	 	testdir=${D}/usr/share/mysql/test \
		benchdir=${D}/usr/share/mysql/bench


	# Move Client Libs
	mv ${D}/usr/lib/mysql/libmysqlclient*.so* ${D}/usr/lib

	insinto /usr/include/mysql
        doins include/my_config.h include/my_dir.h
	dodir /etc/mysql
	cp scripts/mysqlaccess.conf ${D}/etc/mysql
	cp ${FILESDIR}/my.cnf ${D}/etc/mysql

	dodir /etc/rc.d/init.d
	cp ${FILESDIR}/mysql ${D}/etc/rc.d/init.d/mysql
	
	# MySQL Docs
	

	dodoc README MIRRORS
	cd ${S}/Docs 
	docinto ps
	dodoc manual.ps 
	docinto txt
	dodoc manual.txt
	docinto html
	dodoc manual.html manual_toc.html
		
}

pkg_config () {

  echo "Setting up symlinks..."
  ${ROOT}/usr/sbin/rc-update add mysql

}







