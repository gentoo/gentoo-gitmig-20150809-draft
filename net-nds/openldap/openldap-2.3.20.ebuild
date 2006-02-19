# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/openldap/openldap-2.3.20.ebuild,v 1.1 2006/02/19 23:54:56 jokey Exp $

inherit flag-o-matic toolchain-funcs eutils multilib

COMPAT21_PV="2.1.30"
COMPAT21_P="${PN}-${COMPAT21_PV}"
COMPAT21_S="${WORKDIR}/${COMPAT21_P}"

COMPAT22_PV="2.2.28"
COMPAT22_P="${PN}-${COMPAT22_PV}"
COMPAT22_S="${WORKDIR}/${COMPAT22_P}"

DESCRIPTION="LDAP suite of application and development tools"
HOMEPAGE="http://www.OpenLDAP.org/"
SRC_URI="mirror://openldap/openldap-release/${P}.tgz
		mirror://openldap/openldap-release/${COMPAT21_P}.tgz
		mirror://openldap/openldap-release/${COMPAT22_P}.tgz"

LICENSE="OPENLDAP"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="berkdb crypt debug gdbm ipv6 kerberos minimal odbc perl readline samba
	sasl selinux slp ssl tcpd"

RDEPEND=">=sys-libs/ncurses-5.1
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	readline? ( >=sys-libs/readline-4.1 )
	sasl? ( >=dev-libs/cyrus-sasl-2.1.7-r3 )
	odbc? ( dev-db/unixODBC )
	slp? ( >=net-libs/openslp-1.0 )
	perl? ( >=dev-lang/perl-5.6 )
	samba? ( >=dev-libs/openssl-0.9.6 )
	selinux? ( sec-policy/selinux-openldap )
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
	)"

DEPEND="${RDEPEND}
		>=sys-devel/libtool-1.5.18-r1
		>=sys-apps/sed-4"

# for tracking versions
OPENLDAP_VERSIONTAG="/var/lib/openldap-data/.version-tag"

openldap_upgrade_warning() {
	ewarn "If you are upgrading from OpenLDAP-2.1 or 2.2, and run slapd on this"
	ewarn "machine please see the ebuild for upgrade instructions, otherwise"
	ewarn "you may corrupt your database!"
	echo
	ewarn "Part of the configuration file syntax has changed in 2.3:"
	ewarn "'access to attribute=' is now 'access to attrs='"
	echo
	ewarn "The libraries of 2.1 and 2.2 are provided but please"
	ewarn "consider updating your applications to only use 2.3"
	ewarn "as the backwards compatible libraries will be removed in future."
	ewarn "Do rebuild your applications against the new libraries do:"
	ewarn "# revdep-rebuild --soname liblber.so.2"
	ewarn "# revdep-rebuild --soname libldap.so.2"
	ewarn "# revdep-rebuild --soname libldap_r.so.2"
	echo
	ewarn "Note that there are substantial changes to how openldap functions"
	ewarn "in 2.3, if you are using bdb as a backend. You should issue the"
	ewarn "following commands in order to get openldap to run:"
	ewarn "mkdir /etc/openldap"
	ewarn "slaptest -f /etc/openldap/slapd.conf -F /etc/openldap/slapd.d"
	ewarn "chown -R ldap:ldap /etc/openldap/slapd.d"
	ewarn "Make sure that '-F /etc/openldap/slapd.d' is included in the"
	ewarn "/etc/conf.d/slapd configuration file. While it is possible to"
	ewarn "skip the slaptest line above, it is inadvisable to do so as by"
	ewarn "using slaptest you are able to resolve any configuration syntax"
	ewarn "changes that might be present, however, if you are sure that"
	ewarn "your syntax will work for 2.3 then you may simply create the"
	ewarn "directory, set the permissions and ensure that the"
	ewarn "/etc/conf.d/slapd has the extra information in it and"
	ewarn "openldap will automatically create the new directory structure"
	ewarn "and populate it with data."
	echo
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
	if has_version '<net-nds/openldap-2.3' && [ -n "$datafiles" ]; then
		eerror "A possible old installation of OpenLDAP was detected"
		eerror "As major version upgrades to 2.3 from lower versions can corrupt your"
		eerror "database, you need to dump your database and re-create it afterwards."
		eerror ""
		d="$(date -u +%s)"
		l="/root/ldapdump.${d}"
		i="${l}.raw"
		eerror " 1. /etc/init.d/slurpd stop ; /etc/init.d/slapd stop"
		eerror " 2. slapcat -l ${i}"
		eerror " 3. egrep -v '^entryCSN:' <${i} >${l}"
		eerror " 4. emerge unmerge '<=net-nds/openldap-2.2*'"
		eerror " 5. mv /var/lib/openldap-data/ /var/lib/openldap-data.old/"
		eerror " 6. emerge '>=net-nds/openldap-2.3'"
		eerror " 7. etc-update, and ensure that you apply the changes"
		eerror " 8. slapadd -l ${l}"
		eerror " 9. chown ldap:ldap /var/lib/openldap-data/*"
		eerror "10. /etc/init.d/slapd start"
		eerror "11. check that your data is intact."
		eerror "12. set up the new replication system."
		eerror ""
		eerror "This install will not proceed until your old data directory"
		eerror "is at least moved out of the way."
		die "Warning direct upgrade unsafe!"
	fi
	openldap_upgrade_warning
	if use perl && built_with_use dev-lang/perl minimal ; then
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

	# Fixes for 2.3
	einfo "Applying patches for 2.3"

	# supersedes old fix for bug #31202
	EPATCH_OPTS="-p1 -d ${S}" epatch ${FILESDIR}/${PN}-2.2.14-perlthreadsfix.patch

	# ximian connector 1.4.7 ntlm patch
	EPATCH_OPTS="-p0 -d ${S}" epatch ${FILESDIR}/${PN}-2.2.6-ntlm.patch

	# fixes for 2.2
	einfo "Applying patches for 2.2 compat lib"

	# Fix up DB-4.0 linking problem
	# remember to autoconf! this expands configure by 500 lines (4 lines to m4
	# stuff).
	EPATCH_OPTS="-p1 -d ${COMPAT22_S}" epatch ${FILESDIR}/${PN}-2.2.14-db40.patch

	# supersedes old fix for bug #31202
	EPATCH_OPTS="-p1 -d ${COMPAT22_S}" epatch ${FILESDIR}/${PN}-2.2.14-perlthreadsfix.patch

	# ximian connector 1.4.7 ntlm patch
	EPATCH_OPTS="-p0 -d ${COMPAT22_S}" epatch ${FILESDIR}/${PN}-2.2.6-ntlm.patch

	# make autoconf-archive compatible
	EPATCH_OPTS="-p0 -d ${COMPAT22_S}" epatch ${FILESDIR}/${PN}-2.2.28-autoconf-archived-fix.patch

	# make autoconf-archive compatible
	EPATCH_OPTS="-p0 -d ${COMPAT22_S}" epatch ${FILESDIR}/${PN}-2.2.28-r1-configure.in-rpath.patch

	# fixes for 2.1
	einfo "Applying patches for 2.1 compat lib"

	# Fix up DB-4.0 linking problem
	# remember to autoconf! this expands configure by 500 lines (4 lines to m4
	# stuff).
	EPATCH_OPTS="-p1 -d ${COMPAT21_S}" epatch ${FILESDIR}/${PN}-2.1.30-db40.patch
	EPATCH_OPTS="-p1 -d ${COMPAT21_S}" epatch ${FILESDIR}/${PN}-2.1.30-tls-activedirectory-hang-fix.patch

	# Security bug #96767
	# http://bugzilla.padl.com/show_bug.cgi?id=210
	EPATCH_OPTS="-p1 -d ${COMPAT21_S}" epatch ${FILESDIR}/${PN}-2.2.26-tls-fix-connection-test.patch

	# make files ready for new autoconf
	EPATCH_OPTS="-p0 -d ${COMPAT21_S}" epatch ${FILESDIR}/${PN}-2.1.30-autoconf25.patch

	# make autoconf-archive compatible
	EPATCH_OPTS="-p0 -d ${COMPAT21_S}" epatch ${FILESDIR}/${PN}-2.1.30-autoconf-archived-fix.patch

	# fix AC calls bug #114544
	EPATCH_OPTS="-p0 -d ${COMPAT21_S}/build" epatch ${FILESDIR}/${PN}-2.1.30-m4_underquoted.patch

	# supersedes old fix for bug #31202
	EPATCH_OPTS="-p0 -d ${COMPAT21_S}" epatch ${FILESDIR}/${PN}-2.1.27-perlthreadsfix.patch

	export WANT_AUTOMAKE="1.9"
	export WANT_AUTOCONF="2.5"

	# reconf compat for RPATH solve (bug #105380)
	for each in ${COMPAT21_P} ${COMPAT22_P}
	do
		LOCAL_S=${WORKDIR}/${each}

		# ensure correct SLAPI path by default
		sed -i -e 's,\(#define LDAPI_SOCK\).*,\1 "/var/run/openldap/slapd.sock",' \
			${LOCAL_S}/include/ldap_defaults.h

		cd ${LOCAL_S}
		einfo "Running libtoolize on ${each}"
		libtoolize --copy --force --automake
		einfo "Running aclocal on ${each}"
		aclocal || die "aclocal failed"

		# apply RPATH patch
		EPATCH_OPTS="-p0 -d ${LOCAL_S}" epatch ${FILESDIR}/${PN}-2.1.30-rpath.patch

		einfo "Running autoconf on ${each}"
		autoconf || die "autoconf failed"
	done
}

src_compile() {
	local myconf

	# HDB is only available with BerkDB
	myconf_berkdb='--enable-bdb --enable-ldbm-api=berkeley --enable-hdb=mod'
	myconf_gdbm='--disable-bdb --enable-ldbm-api=gdbm --disable-hdb'

	use debug && myconf="${myconf} --enable-debug" # there is no disable-debug

	# enable slapd/slurpd servers if not doing a minimal build
	# slurpd is deprecated by syncrepl in 2.3
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
		# repeat? - is there a reason for this?
		#myconf="${myconf} --disable-slurpd"
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

	# now build old compat libs
	for each in ${COMPAT21_P} ${COMPAT22_P}
	do
		LOCAL_S=${WORKDIR}/${each}
		cd ${LOCAL_S} && \
		econf \
			--disable-static --enable-shared \
			--libexecdir=/usr/$(get_libdir)/openldap \
			--disable-slapd --disable-aci --disable-cleartext --disable-crypt \
			--disable-lmpasswd --disable-spasswd --enable-modules \
			--disable-phonetic --disable-rewrite --disable-rlookups --disable-slp \
			--disable-wrappers --disable-bdb --disable-dnssrv --disable-ldap \
			--disable-ldbm --disable-meta --disable-monitor --disable-null \
			--disable-passwd --disable-perl --disable-shell --disable-sql \
			--disable-slurpd || die "configure for ${each} failed"
		make depend || die "make depend on ${each} failed"
		cd ${LOCAL_S}/libraries/liblber && make liblber.la || die "make for ${each} liblber.la failed"
		cd ${LOCAL_S}/libraries/libldap && make libldap.la || die "make for ${each}libldap.la failed"
		cd ${LOCAL_S}/libraries/libldap_r && make libldap_r.la || die "make for ${each} libldap_r.la failed"
	done
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

	if ! use nocompat; then
	    dolib.so ${COMPAT21_S}/libraries/liblber/.libs/liblber.so.2.0.130 || \
	    die "failed to install 2.1 liblber"
	    dolib.so ${COMPAT21_S}/libraries/libldap/.libs/libldap.so.2.0.130 || \
	    die "failed to install 2.1 libldap"
	    dolib.so ${COMPAT21_S}/libraries/libldap_r/.libs/libldap_r.so.2.0.130 || \
	    die "failed to install 2.1 libldap_r"

	    dolib.so ${COMPAT22_S}/libraries/liblber/.libs/liblber-2.2.so.7.0.21 || \
	    die "failed to install 2.1 liblber"
	    dosym liblber-2.2.so.7.0.21 /usr/$(get_libdir)/liblber-2.2.so.7
	    dolib.so ${COMPAT22_S}/libraries/libldap/.libs/libldap-2.2.so.7.0.21 || \
	    die "failed to install 2.1 libldap"
	    dosym libldap-2.2.so.7.0.21 /usr/$(get_libdir)/libldap-2.2.so.7
	    dolib.so ${COMPAT22_S}/libraries/libldap_r/.libs/libldap_r-2.2.so.7.0.21 || \
	    die "failed to install 2.1 libldap_r"
	    dosym libldap_r-2.2.so.7.0.21 /usr/$(get_libdir)/libldap_r-2.2.so.7
	fi
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

	if use ssl; then
		ewarn "Self-signed SSL certificates are treated harshly by OpenLDAP 2.[12]"
		ewarn "add 'TLS_REQCERT never' if you want to use them."
	fi
	ewarn "See Berkeley Database tuning options for OpenLDAP at http://www.openldap.org/faq/data/cache/1072.html"

	einfo "Please note there is an example BDB configuration file in"
	einfo "/etc/openldap and /var/lib/openldap-data. Review these config"
	einfo "files for possible performance enhancements."
	einfo
	openldap_upgrade_warning

	# Reference inclusion bug #77330
	echo
	einfo "Getting started using OpenLDAP? There is some documentation available:"
	einfo "Gentoo Guide to OpenLDAP Authentication"
	einfo "(http://www.gentoo.org/doc/en/ldap-howto.xml)"
}
