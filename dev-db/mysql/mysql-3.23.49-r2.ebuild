# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql/mysql-3.23.49-r2.ebuild,v 1.2 2002/07/23 03:05:05 rphillips Exp $

# NB: Databases are now in /var/lib/mysql vs. the old /var/mysql.  If you are
# upgrading from a recent mysql version, you should be able to simply move your
# databases into the new directory, but to be absolutely *safe* you should:
# - dump all of your databases
# - stop mysql if it is running
# - delete the old /var/mysql directory
# - emerge this ebuild
# - run /usr/bin/mysql_install_db or ebuild this-ebuild.ebuild config
# - start up mysql
# - re-create all of your databases
# - re-load your data
# If you are *not* upgrading, then you can just emerge this ebuild and
# either run /usr/bin/mysql_install_db or ebuild this-ebuild.ebuild config :)

DESCRIPTION="A fast, multi-threaded, multi-user SQL database server."
HOMEPAGE="http://www.mysql.com/"

S=${WORKDIR}/${P}
SRC_URI="http://www.kernelnotes.de/MySQL/Downloads/MySQL-3.23/${P}.tar.gz
	ftp://mysql.valueclick.com/pub/mysql/Downloads/MySQL-3.23/${P}.tar.gz
	http://mysql.he.net/Downloads/MySQL-3.23/${P}.tar.gz
	http://web.tryc.on.ca/mysql/Downloads/MySQL-3.23/${P}.tar.gz
	ftp://ftp.sunet.se/pub/unix/databases/relational/mysql/Downloads/MySQL-3.23/${P}.tar.gz"

RDEPEND="virtual/glibc readline? ( >=sys-libs/readline-4.1 ) >=sys-libs/ncurses-5.1 >=sys-libs/zlib-1.1.3"
DEPEND="${RDEPEND} tcpd? ( >=sys-apps/tcp-wrappers-7.6 ) sys-devel/perl sys-apps/procps"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

src_unpack() {

	unpack ${A} ; cd ${S}
	# Gentoo 1.3+ uses db 4.0.x by default..
	if [[ "${COMPILER}" != "gcc3" ]]; then
	# for -ldb-3.2 instead of -ldb, because gentoo has -ldb1 instead
	echo "blep"
	patch -p1 < ${FILESDIR}/mysql-3.23-db-3.2.3.diff || die
	fi
	# required for qmail-mysql
	patch -p0 < ${FILESDIR}/mysql-3.23-nisam.h.diff || die
	# zap startup script messages
	patch -p1 < ${FILESDIR}/mysql-3.23-install-db-sh.diff || die
	# zap binary distribution stuff
	patch -p1 < ${FILESDIR}/mysql-3.23-safe-mysqld-sh.diff || die
	# for correct hardcoded sysconf directory
	patch -p1 < ${FILESDIR}/mysql-3.23-my-print-defaults.diff || die

	aclocal || die
	automake || die
	autoconf || die
}

src_compile() {

	local myconf
	# means use the system readline
	use readline && myconf="${myconf} --without-readline"
	if [[ "${COMPILER}" != "gcc3" ]]; then
		echo "jsqkdk"
		use berkdb && myconf="${myconf} --with-berkeley-db --with-berkeley-db-includes=/usr/include/db3 --with-berkeley-db-libs=/usr/lib"
	else
		echo "bleh"
		use berkdb && myconf="${myconf} --with-berkeley-db"
	fi
	use berkdb || myconf="${myconf} --without-berkeley-db"
	use static && myconf="${myconf} --with-mysqld-ldflags=-all-static --disable-shared"
	use static || myconf="${myconf} --enable-shared --enable-static"
	use tcpd && myconf="${myconf} --with-libwrap"
	use innodb && myconf="${myconf} --with-innodb"

	if [ "$DEBUG" == "true" ] ; then
		myconf="${myconf} --with-debug"
	else
		myconf="${myconf} --without-debug"
	fi

	# CXX must be g++ because gcc|c++ does not find /usr/lib/gcc-lib/libstc+++.so.
	# the compiler flags are needed to address stability issues.
	CC=gcc \
	CFLAGS="${CFLAGS/-O?/} -O2 -fomit-frame-pointer" \
	CXX=g++ \
	CXXFLAGS="${CXXFLAGS/-O?/} -O2 -fomit-frame-pointer -felide-constructors -fno-exceptions -fno-rtti" \
	./configure \
		--prefix=/usr \
		--libdir=/usr/lib \
		--exec-prefix=/usr \
		--datadir=/usr/share \
		--libexecdir=/usr/sbin \
		--sysconfdir=/etc/mysql \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--includedir=/usr/include \
		--localstatedir=/var/lib/mysql \
		--with-raid \
		--with-low-memory \
		--enable-assembler \
		--with-charset=latin1 \
		--with-mysqld-user=mysql \
		--with-extra-charsets=all \
		--enable-thread-safe-client \
		--with-client-ldflags=-lstdc++ \
		--with-comment="${PF}.ebuild package" \
		--with-unix-socket-path=/var/run/mysqld/mysqld.sock \
		--host=${CHOST} ${myconf} || die "bad ./configure"

	make || die "compile problem"
}

src_install() {

	dodir /var/lib/mysql /var/run/mysqld /var/log/mysql
	make install DESTDIR=${D} benchdir_root=/usr/share/mysql || die

	# eeek, not sure whats going on here.. are these needed by anything?
	use innodb && ( insinto /usr/lib/mysql ; doins ${WORKDIR}/../libs/* )

	# move client libs, install a couple of missing headers
	mv ${D}/usr/lib/mysql/libmysqlclient*.so* ${D}/usr/lib
	dosym ../libmysqlclient.so /usr/lib/mysql/libmysqlclient.so
	insinto /usr/include/mysql ; doins include/{my_config.h,my_dir.h}

	# convenience links
	dosym /usr/bin/mysqlcheck /usr/bin/mysqlanalyze
	dosym /usr/bin/mysqlcheck /usr/bin/mysqlrepair
	dosym /usr/bin/mysqlcheck /usr/bin/mysqloptimize

	# while my broom gently sweeps...
	rm -f ${D}/usr/share/mysql/binary-configure
	rm -f ${D}/usr/share/mysql/mysql.server
	rm -f ${D}/usr/share/mysql/make_binary_distribution
	rm -f ${D}/usr/share/mysql/mi_test_all*
	rm -f ${D}/usr/share/mysql/mysql-log-rotate
	rm -f ${D}/usr/share/mysql/mysql*.spec
	rm -f ${D}/usr/share/mysql/my-*.cnf

	dodoc README COPYING COPYING.LIB MIRRORS Docs/{manual.ps,manual.txt}
	docinto conf-samples ; dodoc support-files/my-*.cnf
	docinto html ; dodoc Docs/*.html

	insinto /etc/mysql
	doins ${FILESDIR}/my.cnf scripts/mysqlaccess.conf
	exeinto /etc/init.d ; newexe ${FILESDIR}/mysql.rc6 mysql
}

pkg_config() {

	if [ ! -d ${ROOT}/var/lib/mysql/mysql ] ; then
		einfo "Press ENTER to create the mysql database and set proper"
		einfo "permissions on it, or Control-C to abort now..."
		read
		${ROOT}/usr/bin/mysql_install_db #>>/var/log/mysql/mysql.err 2>&1
	else
		einfo "Hmm, it appears as though you already have the mysql"
		einfo "database in place.  If you are having problems trying"
		einfo "to start mysqld, perhaps you need to manually run"
		einfo "/usr/bin/mysql_install_db and/or check your config"
		einfo "file(s) and/or database(s) and/or logfile(s) :>"
	fi

	# ensure permissions on these just in case...
	chown -R mysql ${ROOT}/var/lib/mysql ${ROOT}/var/run/mysqld
}

pkg_prerm() {

	if [ "$ROOT" = "/" ] && [ -e /dev/shm/.init.d/started/mysql ] ; then
		/etc/init.d/mysql stop
	fi
}

pkg_preinst() {

	if [ "$ROOT" = "/" ] && [ -e /dev/shm/.init.d/started/mysql ] ; then
		/etc/init.d/mysql stop
	fi
}

pkg_postinst() {

	# NB:  most of this stuff has been integrated into Gentoo's baselayout
	# now, for convenience.  So Ill remove it soon.  Shouldnt hurt to leave
	# it here for a few more versions though...

	# ensure the following arrangement:
	# /etc/passwd: mysql:x:60:60:mysql:/var/lib/mysql:/dev/null
	# /etc/group:  mysql::60:
	#
	# creating mysql group if he isn't already there
	if ! grep -q ^mysql: /etc/group ; then
		#echo Adding system group: mysql.
		groupadd -g 60 mysql || die "problem adding group mysql"
	fi
	# creating mysql user if he isn't already there
	if ! grep -q ^mysql: /etc/passwd ; then
		#echo Adding system user: mysql.
		useradd -g mysql -s /dev/null -d /var/lib/mysql -c "mysql" mysql
		assert "problem adding user mysql"
	fi
	# modifying him if he was already there
	usermod -c "mysql" mysql || die "usermod problem"
	usermod -d "/var/lib/mysql" mysql || die "usermod problem"
	usermod -g "mysql" mysql || die "usermod problem"
	usermod -s "/dev/null" mysql || die "usermod problem"

	# ensure sane permissions on existing databases and /var/run/mysqld
	chown mysql.mysql ${ROOT}/var/lib/mysql ${ROOT}/var/run/mysqld
	find ${ROOT}/var/lib/mysql -not \( -group root -or -group mysql \) -exec chgrp mysql {} \;

	# get these proper and ready to go
	touch ${ROOT}/var/log/mysql/mysql.log ${ROOT}/var/log/mysql/mysql.err
	chown mysql.mysql ${ROOT}/var/log/mysql/mysql.log ${ROOT}/var/log/mysql/mysql.err
	chmod 0600 ${ROOT}/var/log/mysql/mysql.log ${ROOT}/var/log/mysql/mysql.err
}
