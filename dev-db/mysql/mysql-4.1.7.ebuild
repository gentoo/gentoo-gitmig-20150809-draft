# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql/mysql-4.1.7.ebuild,v 1.2 2004/11/18 23:14:53 robbat2 Exp $

inherit eutils gnuconfig
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

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static readline innodb berkdb tcpd ssl perl ruby selinux debug cluster"
RESTRICT="nomirror"

DEPEND="
	!<dev-db/mysql-4.1*
	readline? ( >=sys-libs/readline-4.1 )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6-r6 )
	ssl? ( >=dev-libs/openssl-0.9.6d )
	perl? ( dev-lang/perl )
	>=sys-libs/zlib-1.1.3
	sys-apps/procps
	>=sys-apps/texinfo-4.7
	>=sys-apps/sed-4"
PDEPEND="perl? ( >=dev-perl/DBD-mysql-2.9004 )
		 ruby? ( >=dev-ruby/mysql-ruby-2.5 )"
RDEPEND="${DEPEND} selinux? ( sec-policy/selinux-mysql )"

warning() {
	ewarn
	ewarn "If you're upgrading from MySQL-3.x to 4.0, or 4.0.x to 4.1.x, you"
	ewarn "must recompile the other packages on your system that link with"
	ewarn "libmysqlclient after the upgrade completes.  To obtain such a list"
	ewarn "of packages for your system, you may use 'revdep-rebuild' from"
	ewarn "app-portage/gentoolkit."
	ewarn
	ewarn "TODO: you must also follow the official upgrade instructions (research and write this up here)"
	epause 5
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
	epatch ${FILESDIR}/${PN}-4.0.21-install-db-sh.diff
	#zap binary distribution stuff
	EPATCH_OPTS="-p1 -d ${S}" \
	epatch ${FILESDIR}/${PN}-4.0.18-mysqld-safe-sh.diff
	#required for qmail-mysql
	EPATCH_OPTS="-p0 -d ${S}" \
	epatch ${FILESDIR}/${PN}-4.0-nisam.h.diff
	#for correct hardcoded sysconf directory
	EPATCH_OPTS="-p1 -d ${S}" \
	epatch ${FILESDIR}/${PN}-4.0-my-print-defaults.diff
	# NPTL support
	EPATCH_OPTS="-p1 -d ${S}" \
	epatch ${FILESDIR}/${PN}-4.0.18-gentoo-nptl.diff

	# attempt to get libmysqlclient_r linked against ssl if USE="ssl" enabled
	# i would really prefer to fix this at the Makefile.am level, but can't
	# get the software to autoreconf as distributed - too many missing files
	EPATCH_OPTS="-p1 -d ${S}" \
	epatch ${FILESDIR}/${PN}-4.0.21-thrssl.patch

	if use tcpd; then
		EPATCH_OPTS="-p1 -d ${S}" \
		epatch ${FILESDIR}/${PN}-4.0.14-r1-tcpd-vars-fix.diff
	fi

	cd ${S}
	autoconf
	# Saving this for a rainy day, in case we need it again
	#WANT_AUTOMAKE=1.7 automake
	gnuconfig_update
}

src_compile() {
	local myconf

	#The following fix is due to a bug with bdb on sparc's. See:
	#http://www.geocrawler.com/mail/msg.php3?msg_id=4754814&list=8
	if use sparc || use alpha || use hppa || use mips
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

	# MySQL CLuster UseFlag
	if use cluster; then
		myconf="${myconf} --with-ndbcluster"
	fi

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
	mv ${D}/usr/$(get_libdir)/mysql/libmysqlclient*.so* ${D}/usr/$(get_libdir)
	dosym ../libmysqlclient.so /usr/$(get_libdir)/mysql/libmysqlclient.so
	dosym ../libmysqlclient_r.so /usr/$(get_libdir)/mysql/libmysqlclient_r.so
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
			#DATADIR=`/usr/sbin/mysqld  --help |grep '^datadir' | awk '{print $2}'`
			#DATADIR=`my_print_defaults mysqld | grep -- '^--datadir' | tail -n1 | sed -e 's|^--datadir=||'`
			DATADIR=`my_print_defaults mysqld | sed -ne '/datadir/s|^--datadir=||p' | tail -n1`
		fi
		if [ -z "${DATADIR}" ]; then
			DATADIR="/var/lib/mysql/"
		fi
		chown -R mysql:mysql ${DATADIR}
		chmod 0750 ${DATADIR}
	else
		einfo "Hmm, it appears as though you already have the mysql"
		einfo "database in place.  If you are having problems trying"
		einfo "to start mysqld, perhaps you need to manually run"
		einfo "/usr/bin/mysql_install_db and/or check your config"
		einfo "file(s) and/or database(s) and/or logfile(s)."
	fi
}

pkg_preinst() {
	enewgroup mysql 60 || die "problem adding group mysql"
	enewuser mysql 60 /dev/null /var/lib/mysql mysql || die "problem adding user mysql"
}

pkg_postinst() {
	#empty dirs...
	install -d -m0750 -o mysql -g mysql ${ROOT}/var/lib/mysql
	install -d -m0755 -o mysql -g mysql ${ROOT}/var/run/mysqld
	install -d -m0755 -o mysql -g mysql ${ROOT}/var/log/mysql

	#secure the logfiles... does this bother anybody?
	touch ${ROOT}/var/log/mysql/mysql.{log,err}
	chown mysql:mysql ${ROOT}/var/log/mysql/mysql*
	chmod 0660 ${ROOT}/var/log/mysql/mysql*
	# secure some directories
	chmod 0750 ${ROOT}/var/log/mysql ${ROOT}/var/lib/mysql

	#your friendly public service announcement...
	einfo
	einfo "You might want to run:"
	einfo "\"ebuild /var/db/pkg/dev-db/${PF}/${PF}.ebuild config\""
	einfo "if this is a new install."
	einfo

	warning
}
