# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql/mysql-4.0.13.ebuild,v 1.1 2003/05/21 20:50:14 robbat2 Exp $

#to accomodate -laadeedah releases
NEWP=${P}

SVER=${PV%.*}
#normal releases:
SDIR=MySQL-${SVER}
#for a pre-release:
#SDIR=MySQL-${SVER}-Pre

S=${WORKDIR}/${NEWP}

DESCRIPTION="A fast, multi-threaded, multi-user SQL database server"
HOMEPAGE="http://www.mysql.com/"
SRC_URI="mirror://mysql/Downloads/${SDIR}/${NEWP}.tar.gz"

KEYWORDS="~x86 ~sparc ~ppc arm"
LICENSE="GPL-2"
SLOT="0"
IUSE="static readline innodb berkdb tcpd ssl"

DEPEND="readline? ( >=sys-libs/readline-4.1 )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	ssl? ( >=dev-libs/openssl-0.9.6d )
	>=sys-libs/zlib-1.1.3
	dev-lang/perl
	sys-apps/procps
	app-admin/gentoolkit"
PDEPEND="perl? ( dev-perl/DBI dev-perl/DBD-mysql )"

warning() {
	ewarn
	ewarn "If you're upgrading from MySQL-3.x, you must recompile the other"
	ewarn "packages on your system that link with libmysqlclient after the"
	ewarn "upgrade completes.  To obtain such a list of packages for your"
	ewarn "system, you may use the: ${FILESDIR}/rebuilder.sh"
	ewarn "script."
	ewarn
	sleep 5
}

pkg_setup() {
	warning
}

src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	#required for qmail-mysql
	patch -p0 < ${FILESDIR}/mysql-4.0-nisam.h.diff || die
	#zap startup script messages
	patch -p1 < ${FILESDIR}/mysql-4.0.4-install-db-sh.diff || die
	#zap binary distribution stuff
	patch -p1 < ${FILESDIR}/mysql-4.0-mysqld-safe-sh.diff || die
	#for correct hardcoded sysconf directory
	patch -p1 < ${FILESDIR}/mysql-4.0-my-print-defaults.diff || die
	#patch -p1 < ${FILESDIR}/mysql-3.23.51-tcpd.patch || die
}

src_compile() {
	local myconf
	#The following fix is due to a bug with bdb on sparc's. See: 
	#http://www.geocrawler.com/mail/msg.php3?msg_id=4754814&list=8
	if use sparc || use sparc64 || use alpha || use hppa
	then
		myconf="${myconf} --without-berkeley-db"
	else
		use berkdb && myconf="${myconf} --with-berkeley-db=./bdb"
		use berkdb || myconf="${myconf} --without-berkeley-db"
	fi
	#readline pair reads backwards on purpose, DONT change it around, Ok?
	use readline && myconf="${myconf} --without-readline"
	use readline || myconf="${myconf} --with-readline"
	use static && myconf="${myconf} --with-mysqld-ldflags=-all-static --disable-shared"
	use static || myconf="${myconf} --enable-shared --enable-static"
	use tcpd && myconf="${myconf} --with-libwrap"
	use tcpd || myconf="${myconf} --without-libwrap"
	use innodb && myconf="${myconf} --with-innodb"
	use innodb || myconf="${myconf} --without-innodb"
	use ssl && myconf="${myconf} --with-vio --with-openssl"
	use ssl || myconf="${myconf} --without-openssl"
	[ -n "${DEBUGBUILD}" ] && myconf="${myconf} --with-debug"
	[ -n "${DEBUGBUILD}" ] || myconf="${myconf} --without-debug"

	#glibc-2.3.2_pre fix; bug #16496
	export CFLAGS="${CFLAGS} -DHAVE_ERRNO_AS_DEFINE=1"

        #bug fix for #15099, should make this api backward compatible, thanks dragon
        export CFLAGS="${CFLAGS} -DUSE_OLD_FUNCTIONS"

	#the compiler flags are as per their "official" spec ;)
	CFLAGS="${CFLAGS/-O?/} -O3" \
	CXXFLAGS="${CXXFLAGS/-O?/} -O3 -felide-constructors -fno-exceptions -fno-rtti" \
	econf \
		--libexecdir=/usr/sbin \
		--sysconfdir=/etc/mysql \
		--localstatedir=/var/lib/mysql \
		--with-raid \
		--with-low-memory \
		--enable-assembler \
		--with-charset=latin1 \
		--enable-local-infile \
		--with-mysqld-user=mysql \
		--with-extra-charsets=all \
		--enable-thread-safe-client \
		--with-client-ldflags=-lstdc++ \
		--with-comment="Gentoo Linux ${PF}" \
		--with-unix-socket-path=/var/run/mysqld/mysqld.sock \
		${myconf} || die "bad ./configure"

	emake || die "compile problem"
}

src_install() {
	make install DESTDIR=${D} benchdir_root=/usr/share/mysql || die

	#eeek, not sure whats going on here.. are these needed by anything?
#	use innodb && insinto /usr/lib/mysql && doins ${WORKDIR}/../libs/*

	#move client libs, install a couple of missing headers
	mv ${D}/usr/lib/mysql/libmysqlclient*.so* ${D}/usr/lib
	dosym ../libmysqlclient.so /usr/lib/mysql/libmysqlclient.so
	dosym ../libmysqlclient_r.so /usr/lib/mysql/libmysqlclient_r.so
	insinto /usr/include/mysql ; doins include/{my_config.h,my_dir.h}

	#convenience links
	dosym /usr/bin/mysqlcheck /usr/bin/mysqlanalyze
	dosym /usr/bin/mysqlcheck /usr/bin/mysqlrepair
	dosym /usr/bin/mysqlcheck /usr/bin/mysqloptimize

	#various junk
	rm -f ${D}/usr/share/mysql/binary-configure
	rm -f ${D}/usr/share/mysql/mysql.server
	rm -f ${D}/usr/share/mysql/make_binary_distribution
	rm -f ${D}/usr/share/mysql/mi_test_all*
	rm -f ${D}/usr/share/mysql/mysql-log-rotate
	rm -f ${D}/usr/share/mysql/mysql*.spec
	rm -f ${D}/usr/share/mysql/my-*.cnf

	#hmm what about all the very nice benchmark/test scripts
	#in /usr/share/mysql/sql-bench
	if ! use perl; then
		rm -f ${D}/usr/bin/mysql_setpermission
	fi

	dodoc README COPYING COPYING.LIB MIRRORS Docs/{manual.ps,manual.txt}
	docinto conf-samples ; dodoc support-files/my-*.cnf
	dohtml -r Docs/*

	insinto /etc/mysql
	doins ${FILESDIR}/my.cnf scripts/mysqlaccess.conf
	exeinto /etc/init.d
	newexe ${FILESDIR}/mysql-4.0.rc6 mysql
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
		einfo "file(s) and/or database(s) and/or logfile(s)."
	fi
}

pkg_preinst() {
	if ! groupmod mysql; then
		groupadd -g 60 mysql || die "problem adding group mysql"
	fi

	if ! id mysql; then
		useradd -g mysql -s /dev/null -d /var/lib/mysql -c "mysql" mysql
		assert "problem adding user mysql"
	fi
}

pkg_postinst() {
	#empty dirs...
	install -d -m0755 -o mysql -g mysql ${ROOT}/var/lib/mysql
	install -d -m0755 -o mysql -g mysql ${ROOT}/var/run/mysqld
	install -d -m0755 -o mysql -g mysql ${ROOT}/var/log/mysql

	#secure the logfiles... does this bother anybody?
	touch ${ROOT}/var/log/mysql/mysql.{log,err}
	chown mysql.mysql ${ROOT}/var/log/mysql/mysql.{log,err}
	chmod 0660 ${ROOT}/var/log/mysql/mysql.{log,err}

	#your friendly public service announcement...
	einfo
	einfo "You might want to run:"
	einfo "\"ebuild /var/db/pkg/dev-db/${PF}/${PF}.ebuild config\""
	einfo "if this is a new install."
	einfo

	warning
}
