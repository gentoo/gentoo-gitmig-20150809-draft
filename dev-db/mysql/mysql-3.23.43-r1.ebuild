# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Parag Mehta <pm@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql/mysql-3.23.43-r1.ebuild,v 1.2 2001/10/30 01:50:23 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The MySQL Database"
SRC_URI="ftp://mysql.valueclick.com/mysql/Downloads/MySQL-3.23/${P}.tar.gz
	 http://www.mysql.com/Downloads/MySQL-3.23/${P}.tar.gz"

HOMEPAGE="http://www.mysql.com/"

DEPEND="virtual/glibc
        sys-devel/automake
        sys-devel/libtool
        sys-devel/autoconf
        sys-apps/procps
        tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
        readline? ( >=sys-libs/readline-4.1 )
        >=sys-libs/ncurses-5.1
        >=sys-libs/zlib-1.1.3"

RDEPEND="virtual/glibc
        readline? ( >=sys-libs/readline-4.1 )
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
	aclocal
	automake
	autoconf &>/dev/null
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
    
    CXX=gcc ./configure --host=${CHOST} 			\
			--prefix=/usr 				\
			--enable-shared 			\
			--enable-static				\
			--enable-assembler			\
			--enable-thread-safe-client 		\
			--with-low-memory 			\
			--libdir=/usr/lib 			\
			--libexecdir=/usr/sbin 			\
			--sysconfdir=/etc/mysql 		\
			--localstatedir=/var/mysql 		\
			--infodir=/usr/share/info 		\
			--mandir=/usr/share/man 		\
			--with-mysql-user=mysql 		\
			--with-innodb				\
		        $myconf || die

	make testdir=/usr/share/mysql/test 			\
	     benchdir=/usr/share/mysql/bench || die
}

src_install() {
	# Install MySQL

	make install prefix=${D}/usr 				\
	     libdir=${D}/usr/lib 				\
	     libexecdir=${D}/usr/sbin 				\
	     sysconfdir=${D}/etc/mysql 				\
	     localstatedir=${D}/var/mysql 			\
	     infodir=${D}/usr/share/info 			\
	     mandir=${D}/usr/share/man 				\
	     testdir=${D}/usr/share/mysql/test 			\
	     benchdir=${D}/usr/share/mysql/bench || die


	# Move Client Libs
	mv ${D}/usr/lib/mysql/libmysqlclient*.so* ${D}/usr/lib
        dosym ../libmysqlclient.so /usr/lib/mysql/libmysqlclient.so
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
