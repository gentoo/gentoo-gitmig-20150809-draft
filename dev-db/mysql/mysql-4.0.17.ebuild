# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql/mysql-4.0.17.ebuild,v 1.2 2004/01/10 18:49:24 agriffis Exp $

inherit eutils
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
RESTRICT="nomirror"

KEYWORDS="ia64 ~x86 ~sparc ~ppc ~arm amd64 ~hppa ~alpha"
LICENSE="GPL-2"
SLOT="0"
IUSE="static readline innodb berkdb tcpd ssl perl debug"

DEPEND="readline? ( >=sys-libs/readline-4.1 )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6-r6 )
	ssl? ( >=dev-libs/openssl-0.9.6d )
	perl? ( dev-lang/perl )
	>=sys-libs/zlib-1.1.3
	sys-apps/procps
	>=sys-apps/sed-4"
PDEPEND="perl? ( dev-perl/DBI dev-perl/DBD-mysql )"

warning() {
	ewarn
	ewarn "If you're upgrading from MySQL-3.x, you must recompile the other"
	ewarn "packages on your system that link with libmysqlclient after the"
	ewarn "upgrade completes.  To obtain such a list of packages for your"
	ewarn "system, you may use 'revdep-rebuild' from app-portage/gentoolkit."
	ewarn
	sleep 5
}

pkg_setup() {
	warning
}

src_unpack() {
	if use static && use ssl; then
		local msg="MySQL does not support building statically with SSL support"
		eerror "${msg}"
		die "${msg}"
	fi
	unpack ${A} || die

	#zap startup script messages
	EPATCH_OPTS="-p1 -d ${S}" \
	epatch ${FILESDIR}/${PN}-4.0.16-install-db-sh.diff
	#zap binary distribution stuff
	EPATCH_OPTS="-p1 -d ${S}" \
	epatch ${FILESDIR}/${PN}-4.0.16-mysqld-safe-sh.diff
	#required for qmail-mysql
	EPATCH_OPTS="-p0 -d ${S}" \
	epatch ${FILESDIR}/${PN}-4.0-nisam.h.diff
	#for correct hardcoded sysconf directory
	EPATCH_OPTS="-p1 -d ${S}" \
	epatch ${FILESDIR}/${PN}-4.0-my-print-defaults.diff

	# attempt to get libmysqlclient_r linked against ssl if USE="ssl" enabled
	# i would really prefer to fix this at the Makefile.am level, but can't
	# get the software to autoreconf as distributed - too many missing files
	# Robert Coie <rac@gentoo.org> 2003.06.12
	EPATCH_OPTS="-p1 -d ${S}" \
	epatch ${FILESDIR}/${PN}-4.0.17-thrssl.patch

	if use tcpd; then
		EPATCH_OPTS="-p1 -d ${S}" \
		epatch ${FILESDIR}/${PN}-4.0.14-r1-tcpd-vars-fix.diff
	fi
}

src_compile() {
	local myconf

	#The following fix is due to a bug with bdb on sparc's. See:
	#http://www.geocrawler.com/mail/msg.php3?msg_id=4754814&list=8
	if use sparc || use sparc64 || use alpha || use hppa
	then
		myconf="${myconf} --without-berkeley-db"
	else
		use berkdb \
			&& myconf="${myconf} --with-berkeley-db=./bdb" \
			|| myconf="${myconf} --without-berkeley-db"
	fi

	#readline pair reads backwards on purpose, DONT change it around, Ok?
	# this is because it refers to the building of a bundled readline
	# versus the system copy
	use readline && myconf="${myconf} --without-readline"
	use readline || myconf="${myconf} --with-readline"

	use static \
		&& myconf="${myconf} --with-mysqld-ldflags=-all-static --disable-shared" \
		|| myconf="${myconf} --enable-shared --enable-static"

	myconf="${myconf} `use_with tcpd libwrap`"
	myconf="${myconf} `use_with innodb`"

	use ssl \
		&& myconf="${myconf} --with-vio --with-openssl" \
		|| myconf="${myconf} --without-openssl"

	myconf="${myconf} `use_with debug`"

	#glibc-2.3.2_pre fix; bug #16496
	export CFLAGS="${CFLAGS} -DHAVE_ERRNO_AS_DEFINE=1"

	#bug fix for #15099, should make this api backward compatible
	export CFLAGS="${CFLAGS} -DUSE_OLD_FUNCTIONS"

	#the compiler flags are as per their "official" spec ;)
	#CFLAGS="${CFLAGS/-O?/} -O3" \
	CXXFLAGS="${CXXFLAGS} -felide-constructors -fno-exceptions -fno-rtti" \
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
		--with-embedded-server \
		${myconf} || die "bad ./configure"

	emake || die "compile problem"
}

src_install() {
	make install DESTDIR=${D} benchdir_root=/usr/share/mysql || die

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
	rm -f ${D}/usr/share/mysql/mysql.server
	rm -f ${D}/usr/share/mysql/binary-configure
	rm -f ${D}/usr/share/mysql/make_binary_distribution
	rm -f ${D}/usr/share/mysql/mysql-log-rotate
	rm -f ${D}/usr/share/mysql/{post,pre}install
	rm -f ${D}/usr/share/mysql/mi_test*
	rm -f ${D}/usr/share/mysql/*.spec # Redhat gunk
	rm -f ${D}/usr/share/mysql/*.plist # Apple gunk
	rm -f ${D}/usr/share/mysql/my-*.cnf # Put them elsewhere

	# All of these (ab)use Perl.
	if ! use perl; then
		rm -f ${D}/usr/bin/mysql_setpermission
		rm -rf ${D}/usr/share/mysql/sql-bench
	fi

	dohtml Docs/*.html
	rm -f Docs/*.html
	dodoc README COPYING COPYING.LIB Docs/manual.*
	docinto conf-samples
	dodoc support-files/my-*.cnf

	insinto /etc/mysql
	newins ${FILESDIR}/my.cnf-4.0.14-r1 my.cnf
	doins scripts/mysqlaccess.conf
	exeinto /etc/init.d
	newexe ${FILESDIR}/mysql-4.0.15.rc6 mysql
}

pkg_config() {
	if [ ! -d ${ROOT}/var/lib/mysql/mysql ] ; then
		einfo "Press ENTER to create the mysql database and set proper"
		einfo "permissions on it, or Control-C to abort now..."
		read
		${ROOT}/usr/bin/mysql_install_db #>>/var/log/mysql/mysql.err 2>&1
		# changing ownership of newly created databases to mysql.mysql
		local DATADIR=""
		if [ -f '/etc/mysql/my.cnf' ] ; then
			#DATADIR=`grep ^datadir /etc/mysql/my.cnf | sed -e 's/.*= //'`
			DATADIR=`/usr/sbin/mysqld  --help |grep '^datadir' | awk '{print $2}'`
		fi
		if [ -z "${DATADIR}" ]; then
			DATADIR="/var/lib/mysql/"
		fi
		chown -R mysql:mysql ${DATADIR}
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
	chown mysql:mysql ${ROOT}/var/log/mysql/mysql.{log,err}
	chmod 0660 ${ROOT}/var/log/mysql/mysql.{log,err}

	#your friendly public service announcement...
	einfo
	einfo "You might want to run:"
	einfo "\"ebuild /var/db/pkg/dev-db/${PF}/${PF}.ebuild config\""
	einfo "if this is a new install."
	einfo

	warning
}
