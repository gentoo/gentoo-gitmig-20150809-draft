# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql/mysql-3.23.36.ebuild,v 1.3 2001/04/13 15:52:45 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The MySQL Database"
SRC_URI="ftp://mysql.valueclick.com/mysql/Downloads/MySQL-3.23/${A}
	 http://www.mysql.com/Downloads/MySQL-3.23/${A}"

HOMEPAGE="http://www.mysql.com/"

DEPEND="virtual/glibc
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	berkdb? ( >=sys-libs/db-3.2.3h )
    readline? ( >=sys-libs/readline-4.2 )
    >=sys-libs/ncurses-5.1
    >=sys-libs/zlib-1.1.3"


src_unpack() {
	unpack ${A}
	cd ${S}
	echo ">>> Applying ${P}-db-3.2.3-gentoo.diff..."
	patch -p1 < ${FILESDIR}/${P}-db-3.2.3-gentoo.diff
	# Required for qmail-mysql
	echo ">>> Applying ${P}-nisam.h-gentoo.diff..."
	patch -p0 < ${FILESDIR}/${P}-nisam.h-gentoo.diff
}

src_compile() {

    local myconf

    # MySQL doesn't like optimizations
    export CFLAGS="${CFLAGS/-O?/}"
    export CXXFLAGS="${CXXFLAGS/-O?/}"

    if [ "`use tcpd`" ]
    then
      myconf="--with-libwrap"
    fi

    if [ "`use readline`" ]
    then
      # Means use system readline
      myconf="$myconf --without-readline"
    fi

    if [ "`use berkdb`" ]
    then
      myconf="$myconf --with-berkeley-db --with-berkeley-db-includes=/usr/include/db3 --with-berkeley-db-libs=/usr/lib"
    else
      myconf="$myconf --without-berkdb"
    fi

    if [ "$DEBUG" == "true" ]
    then
      myconf="$myconf --with-debug"
    else
      myconf="$myconf --without-debug"
    fi
    echo $myconf
	try CXX=gcc ./configure --prefix=/usr --host=${CHOST} \
	--enable-shared \
	--enable-static \
	--enable-assembler \
	--enable-thread-safe-client \
	--with-raid \
	--with-low-memory \
	--libdir=/usr/lib \
	--libexecdir=/usr/sbin \
	--sysconfdir=/etc/mysql \
	--localstatedir=/var/mysql \
	--infodir=/usr/share/info \
	--mandir=/usr/share/man \
	--with-mysql-user=mysql \
    $myconf

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
