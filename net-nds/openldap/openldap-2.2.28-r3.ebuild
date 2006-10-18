# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/openldap/openldap-2.2.28-r3.ebuild,v 1.13 2006/10/18 23:02:30 jokey Exp $

inherit flag-o-matic toolchain-funcs eutils multilib

OLD_PV="2.1.30"
OLD_P="${PN}-${OLD_PV}"
OLD_S="${WORKDIR}/${OLD_P}"

DESCRIPTION="LDAP suite of application and development tools"
HOMEPAGE="http://www.OpenLDAP.org/"
SRC_URI="mirror://openldap/openldap-release/${P}.tgz
	mirror://openldap/openldap-release/${OLD_P}.tgz"

LICENSE="OPENLDAP"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE="berkdb crypt debug gdbm ipv6 kerberos minimal odbc perl readline samba sasl slp ssl tcpd selinux"

RDEPEND=">=sys-libs/ncurses-5.1
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	readline? ( >=sys-libs/readline-4.1 )
	sasl? ( >=dev-libs/cyrus-sasl-2.1.7-r3 )
	odbc? ( dev-db/unixODBC )
	slp? ( >=net-libs/openslp-1.0 )
	perl? ( >=dev-lang/perl-5.6 )
	samba? ( >=dev-libs/openssl-0.9.6 )
	kerberos? ( virtual/krb5 )"

# note that the 'samba' USE flag pulling in OpenSSL is NOT an error.  OpenLDAP
# uses OpenSSL for LanMan/NTLM hashing (which is used in some enviroments, like
# mine at work)!
# Robin H. Johnson <robbat2@gentoo.org> March 8, 2004

# if USE=berkdb
#	pull in sys-libs/db
# else if USE=gdbm
#	pull in sys-libs/gdbm
# else
#	pull in sys-libs/db
RDEPEND_BERKDB=">=sys-libs/db-4.2.52_p2-r1"
RDEPEND_GDBM=">=sys-libs/gdbm-1.8.0"
RDEPEND="${RDEPEND}
	berkdb? ( ${RDEPEND_BERKDB} )
	!berkdb? (
		gdbm? ( ${RDEPEND_GDBM} )
		!gdbm? ( ${RDEPEND_BERKDB} )
	)
	selinux? ( sec-policy/selinux-openldap )"

DEPEND="${RDEPEND}
		>=sys-devel/libtool-1.5.18-r1
		>=sys-apps/sed-4"

# for tracking versions
OPENLDAP_VERSIONTAG="/var/lib/openldap-data/.version-tag"

#DEPEND="${DEPEND} !<net-nds/openldap-2.2"

openldap_upgrade_warning() {
	ewarn "If you are upgrading from OpenLDAP-2.1, and run slapd on this"
	ewarn "machine please see the ebuild for upgrade instructions, otherwise"
	ewarn "you may corrupt your database!"
	echo
	ewarn "Part of the configuration file syntax has changed:"
	ewarn "'access to attribute=' is now 'access to attrs='"
	echo
	ewarn "You must also run revdep-rebuild after upgrading from 2.1 to 2.2:"
	ewarn "# revdep-rebuild --library liblber.so.2"
	ewarn "# revdep-rebuild --library libldap.so.2"
	ewarn "# revdep-rebuild --library libldap_r.so.2"
}

pkg_setup() {
	# grab lines
	openldap_datadirs=""
	if [ -f ${ROOT}/etc/openldap/slapd.conf ]; then
		openldap_datadirs="$(awk '{if($1 == "directory") print $2 }' ${ROOT}/etc/openldap/slapd.conf)"
	fi
	datafiles=""
	for d in $openldap_datadirs; do
		datafiles="${datafiles} $(ls $d/*db* 2>/dev/null)"
	done
	# remove extra spaces
	datafiles="$(echo ${datafiles// })"
	# TODO: read OPENLDAP_VERSIONTAG instead in future
	if has_version '<net-nds/openldap-2.2' && [ -n "$datafiles" ]; then
		eerror "A possible old installation of OpenLDAP was detected"
		eerror "As major version upgrades to 2.2 can corrupt your database"
		eerror "You need to dump your database and re-create it afterwards."
		eerror ""
		d="$(date -u +%s)"
		l="/root/ldapdump.${d}"
		i="${l}.raw"
		eerror " 1. /etc/init.d/slurpd stop ; /etc/init.d/slapd stop"
		eerror " 2. slapcat -l ${i}"
		eerror " 3. egrep -v '^entryCSN:' <${i} >${l}"
		eerror " 4. emerge unmerge '<=net-nds/openldap-2.1*'"
		eerror " 5. mv /var/lib/openldap-data/ /var/lib/openldap-data,2.1/"
		eerror " 6. emerge '>=net-nds/openldap-2.2'"
		eerror " 7. etc-update, and ensure that you apply the changes"
		eerror " 8. slapadd -l ${l}"
		eerror " 9. chown ldap:ldap /var/lib/openldap-data/*"
		eerror "10. /etc/init.d/slapd start"
		eerror "11. check that your data is intact."
		eerror "12. set up the new replication system."
		eerror ""
		eerror "This install will not proceed until your old data directory"
		eerror "is at least moved out of the way."
		#exit 1
		die "Warning direct upgrade unsafe!"
	fi
	openldap_upgrade_warning
	if has_version "<=dev-lang/perl-5.8.8_rc1" && built_with_use dev-lang/perl minimal ; then
		die "You must have a complete (USE='-minimal') Perl install to use the perl backend!"
	fi
}

pkg_preinst() {
	openldap_upgrade_warning
	enewgroup ldap 439
	enewuser ldap 439 -1 /usr/$(get_libdir)/openldap ldap
}

src_unpack() {
	unpack ${A}

	# According to MDK, the link order needs to be changed so that
	# on systems w/ MD5 passwords the system crypt library is used
	# (the net result is that "passwd" can be used to change ldap passwords w/
	#  proper pam support)
	sed -i -e 's/$(SECURITY_LIBS) $(LDIF_LIBS) $(LUTIL_LIBS)/$(LUTIL_LIBS) $(SECURITY_LIBS) $(LDIF_LIBS)/' \
		${S}/servers/slapd/Makefile.in

	# Fix up DB-4.0 linking problem
	# remember to autoconf! this expands configure by 500 lines (4 lines to m4
	# stuff).
	EPATCH_OPTS="-p1 -d ${S}" epatch ${FILESDIR}/${PN}-2.2.14-db40.patch

	# supersedes old fix for bug #31202
	EPATCH_OPTS="-p1 -d ${S}" epatch ${FILESDIR}/${PN}-2.2.14-perlthreadsfix.patch

	# Security bug #96767
	# http://bugzilla.padl.com/show_bug.cgi?id=210
	EPATCH_OPTS="-p1 -d ${S}" epatch ${FILESDIR}/${PN}-2.2.26-tls-fix-connection-test.patch

	# ensure correct SLAPI path by default
	sed -i -e 's,\(#define LDAPI_SOCK\).*,\1 "/var/run/openldap/slapd.sock",' \
		${S}/include/ldap_defaults.h

	# fix up some automake stuff
	#sed -i -e 's,^AC_CONFIG_HEADER,AM_CONFIG_HEADER,' ${S}/configure.in

	# ximian connector 1.4.7 ntlm patch
	#EPATCH_OPTS="-p1 -d ${S}" epatch ${FILESDIR}/${PN}-2.2.28-ximian_connector.patch
	EPATCH_OPTS="-p0 -d ${S}" epatch ${FILESDIR}/${PN}-2.2.6-ntlm.patch

	# fix up stuff for newer autoconf that simulates autoconf-2.13, but doesn't
	# do it perfectly.
	cd ${S}/build
	ln -s shtool install
	ln -s shtool install.sh

	export WANT_AUTOMAKE="1.9"
	export WANT_AUTOCONF="2.5"

	# make files ready for new autoconf
	EPATCH_OPTS="-p0 -d ${WORKDIR}/${OLD_P}" epatch ${FILESDIR}/${PN}-2.1.30-autoconf25.patch
	EPATCH_OPTS="-p0 -d ${S}" epatch ${FILESDIR}/${PN}-2.1.30-autoconf25.patch

	# reconf compat and current for RPATH solve
	cd ${WORKDIR}/${OLD_P}
	einfo "Running libtoolize on ${OLD_P}"
	libtoolize --copy --force
	einfo "Running aclocal on ${OLD_P}"
	aclocal || die "aclocal failed"
	EPATCH_OPTS="-p0 -d ${WORKDIR}/${OLD_P}" epatch ${FILESDIR}/${PN}-2.1.30-rpath.patch
	einfo "Running autoconf on ${OLD_P}"
	autoconf || die "autoconf failed"

	cd ${S}
	einfo "Running libtoolize on ${P}"
	libtoolize --copy --force
	einfo "Running aclocal on ${P}"
	aclocal || die "aclocal failed"
	EPATCH_OPTS="-p0 -d ${S}" epatch ${FILESDIR}/${PN}-2.1.30-rpath.patch
	einfo "Running autoconf on ${P}"
	autoconf || die "autoconf failed"
}

src_compile() {
	local myconf

	# HDB is only available with BerkDB
	myconf_berkdb='--enable-bdb --with-ldbm-api=berkeley --enable-hdb=mod'
	myconf_gdbm='--disable-bdb --with-ldbm-api=gdbm --disable-hdb'

	use debug && myconf="${myconf} --enable-debug" # there is no disable-debug

	# enable slapd/slurpd servers if not doing a minimal build
	if ! use minimal; then
		myconf="${myconf} --enable-slapd --enable-slurpd"
		# base backend stuff
		myconf="${myconf} --enable-ldbm"
		if use berkdb; then
			einfo "Using Berkeley DB for local backend"
			myconf="${myconf} ${myconf_berkdb}"
		elif use gdbm; then
			einfo "Using GDBM for local backend"
			myconf="${myconf} ${myconf_gdbm}"
		else
			ewarn "Neither gdbm or berkdb USE flags present, falling back to"
			ewarn "Berkeley DB for local backend"
			myconf="${myconf} ${myconf_berkdb}"
		fi
		# extra backend stuff
		myconf="${myconf} --enable-passwd=mod --enable-phonetic=mod"
		myconf="${myconf} --enable-dnssrv=mod --enable-ldap"
		myconf="${myconf} --enable-meta=mod --enable-monitor=mod"
		myconf="${myconf} --enable-null=mod --enable-shell=mod"
		myconf="${myconf} `use_enable perl perl mod`"
		myconf="${myconf} `use_enable odbc sql mod`"
		# slapd options
		myconf="${myconf} `use_enable crypt` `use_enable slp`"
		myconf="${myconf} --enable-rewrite --enable-rlookups"
		myconf="${myconf} --enable-aci --enable-modules"
		myconf="${myconf} --enable-cleartext --enable-slapi"
		myconf="${myconf} `use_with samba lmpasswd`"
		# disabled options:
		# --with-bdb-module=dynamic
		# alas, for BSD only:
		# --with-fetch
		# slapd overlay options
		myconf="${myconf} --enable-dyngroup --enable-proxycache"
	else
		myconf="${myconf} --disable-slapd --disable-slurpd"
		myconf="${myconf} --disable-bdb --disable-monitor"
		myconf="${myconf} --disable-slurpd"
	fi
	# basic functionality stuff
	myconf="${myconf} --enable-syslog --enable-dynamic"
	myconf="${myconf} --enable-local --enable-proctitle"

	myconf="${myconf} `use_enable ipv6` `use_enable readline`"
	myconf="${myconf} `use_with sasl cyrus-sasl` `use_enable sasl spasswd`"
	myconf="${myconf} `use_enable tcpd wrappers` `use_with ssl tls`"

	if [ $(get_libdir) != "lib" ] ; then
		append-ldflags -L/usr/$(get_libdir)
	fi

	econf \
		--enable-static \
		--enable-shared \
		--libexecdir=/usr/$(get_libdir)/openldap \
		${myconf} || die "configure failed"

	make depend || die "make depend failed"
	make || die "make failed"

	# special kerberos stuff
	tc-export CC
	if ! use minimal && use kerberos ; then
		cd ${S}/contrib/slapd-modules/passwd/ && \
		${CC} -shared -I../../../include ${CFLAGS} -fPIC \
		-DHAVE_KRB5 -o pw-kerberos.so kerberos.c || \
		die "failed to compile kerberos module"
	fi

	# now build old compat lib
	cd ${OLD_S} && \
	econf \
		--disable-static --enable-shared \
		--libexecdir=/usr/$(get_libdir)/openldap \
		--disable-slapd --disable-aci --disable-cleartext --disable-crypt \
		--disable-lmpasswd --disable-spasswd --enable-modules \
		--disable-phonetic --disable-rewrite --disable-rlookups --disable-slp \
		--disable-wrappers --disable-bdb --disable-dnssrv --disable-ldap \
		--disable-ldbm --disable-meta --disable-monitor --disable-null \
		--disable-passwd --disable-perl --disable-shell --disable-sql \
		--disable-slurpd || die "configure-2.1 failed"
	make depend || die "make-2.1 depend failed"
	cd ${OLD_S}/libraries/liblber && make liblber.la || die "make-2.1 liblber.la failed"
	cd ${OLD_S}/libraries/libldap && make libldap.la || die "make-2.1 libldap.la failed"
	cd ${OLD_S}/libraries/libldap_r && make libldap_r.la || die "make-2.1 libldap_r.la failed"
}

src_test() {
	einfo "Doing tests"
	cd tests ; make tests || die "make tests failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc ANNOUNCEMENT CHANGES COPYRIGHT README LICENSE
	docinto rfc ; dodoc doc/rfc/*.txt

	# openldap modules go here
	# TODO: write some code to populate slapd.conf with moduleload statements
	keepdir /usr/$(get_libdir)/openldap/openldap/

	# make state directories
	for x in data slurp ldbm; do
		keepdir /var/lib/openldap-${x}
		fowners ldap:ldap /var/lib/openldap-${x}
		fperms 0700 /var/lib/openldap-${x}
	done

	echo "OLDPF='${PF}'" >${D}${OPENLDAP_VERSIONTAG}
	echo "# do NOT delete this. it is used" >>${D}${OPENLDAP_VERSIONTAG}
	echo "# to track versions for upgrading." >>${D}${OPENLDAP_VERSIONTAG}

	# manually remove /var/tmp references in .la
	# because it is packaged with an ancient libtool
	for x in ${D}/usr/$(get_libdir)/lib*.la; do
		sed -i -e "s:-L${S}[/]*libraries::" ${x}
	done

	# change slapd.pid location in configuration file
	keepdir /var/run/openldap
	fowners ldap:ldap /var/run/openldap
	fperms 0755 /var/run/openldap

	if ! use minimal; then
		# config modifications
		for f in /etc/openldap/slapd.conf /etc/openldap/slapd.conf.default; do
			sed -e "s:/var/lib/run/slapd.:/var/run/openldap/slapd.:" -i ${D}/${f}
			sed -e "/database\tbdb$/acheckpoint	32	30 # <kbyte> <min>" -i ${D}/${f}
			fowners root:ldap ${f}
			fperms 0640 ${f}
		done
		# install our own init scripts
		exeinto /etc/init.d
		newexe ${FILESDIR}/2.0/slapd slapd
		newexe ${FILESDIR}/2.0/slurpd slurpd
		if [ $(get_libdir) != lib ]; then
			sed -e "s,/usr/lib/,/usr/$(get_libdir)/," -i ${D}/etc/init.d/{slapd,slurpd}
		fi
		insinto /etc/conf.d
		newins ${FILESDIR}/2.0/slapd.conf slapd
		if use kerberos && [ -f ${S}/contrib/slapd-modules/passwd/pw-kerberos.so ]; then
			insinto /usr/$(get_libdir)/openldap/openldap
			doins ${S}/contrib/slapd-modules/passwd/pw-kerberos.so || \
			die "failed to install kerberos passwd module"
		fi
	fi

	# install MDK's ssl cert script
	if use ssl || use samba; then
		dodir /etc/openldap/ssl
		exeinto /etc/openldap/ssl
		#newexe ${FILESDIR}/gencert.sh-2.2.27 gencert.sh
		doexe ${FILESDIR}/gencert.sh
	fi

	dolib.so ${OLD_S}/libraries/liblber/.libs/liblber.so.2.0.130 || \
	die "failed to install old liblber"
	dolib.so ${OLD_S}/libraries/libldap/.libs/libldap.so.2.0.130 || \
	die "failed to install old libldap"
	dolib.so ${OLD_S}/libraries/libldap_r/.libs/libldap_r.so.2.0.130 || \
	die "failed to install old libldap_r"
}

pkg_postinst() {
	if use ssl; then
		# make a self-signed ssl cert (if there isn't one there already)
		if [ ! -e /etc/openldap/ssl/ldap.pem ]
		then
			cd /etc/openldap/ssl
			yes "" | sh gencert.sh
			chmod 640 ldap.pem
			chown root:ldap ldap.pem
		else
			einfo "An LDAP cert already appears to exist, no creating"
		fi
	fi

	# Since moving to running openldap as user ldap there are some
	# permissions problems with directories and files.
	# Let's make sure these permissions are correct.
	chown ldap:ldap /var/run/openldap
	chmod 0755 /var/run/openldap
	chown root:ldap /etc/openldap/slapd.conf{,.default}
	chmod 0640 /etc/openldap/slapd.conf{,.default}
	chown ldap:ldap /var/lib/openldap-{data,ldbm,slurp}

	if use ssl; then
		ewarn "Self-signed SSL certificates are treated harshly by OpenLDAP 2.[12]"
		ewarn "add 'TLS_REQCERT never' if you want to use them."
	fi
	openldap_upgrade_warning
}
