# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/openldap/openldap-2.2.28-r7.ebuild,v 1.15 2007/06/26 02:35:42 mr_bones_ Exp $

WANT_AUTOMAKE="1.9"
WANT_AUTOCONF="2.5"
AT_M4DIR="./build"
inherit autotools eutils flag-o-matic multilib ssl-cert toolchain-funcs

PATCHSETVER=openldap-compatversions-patchset-1.0
DESCRIPTION="LDAP suite of application and development tools"
HOMEPAGE="http://www.OpenLDAP.org/"
SRC_URI="mirror://openldap/openldap-release/${P}.tgz
	mirror://gentoo/${PATCHSETVER}.tar.bz2"

LICENSE="OPENLDAP"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="berkdb crypt debug gdbm ipv6 kerberos minimal odbc perl readline samba sasl slp ssl tcpd selinux"

# note that the 'samba' USE flag pulling in OpenSSL is NOT an error.  OpenLDAP
# uses OpenSSL for LanMan/NTLM hashing (which is used in some enviroments, like
# mine at work)!
# Robin H. Johnson <robbat2@gentoo.org> March 8, 2004

DEPEND="sys-libs/ncurses
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	readline? ( >=sys-libs/readline-4.1 )
	sasl? ( >=dev-libs/cyrus-sasl-2.1.7-r3 )
	odbc? ( dev-db/unixODBC )
	slp? ( >=net-libs/openslp-1.0 )
	perl? ( >=dev-lang/perl-5.6 )
	samba? ( >=dev-libs/openssl-0.9.6 )
	kerberos? ( virtual/krb5 )
	berkdb? ( >=sys-libs/db-4.2.52_p2-r1 )
	!berkdb? (
		gdbm? ( sys-libs/gdbm )
		!gdbm? ( >=sys-libs/db-4.2.52_p2-r1 )
	)
	selinux? ( sec-policy/selinux-openldap )"
RDEPEND="${DEPEND}"

PATCHDIR=${WORKDIR}/${PATCHSETVER}

# for tracking versions
OPENLDAP_VERSIONTAG="/var/lib/openldap-data/.version-tag"

pkg_setup() {
	# grab lines
	openldap_datadirs=""
	if [ -f "${ROOT}etc/openldap/slapd.conf" ]; then
		openldap_datadirs="$(awk '{if($1 == "directory") print $2 }' ${ROOT}etc/openldap/slapd.conf)"
	fi
	datafiles=""
	for d in $openldap_datadirs; do
		datafiles="${datafiles} $(ls $d/*db* 2>/dev/null)"
	done
	# remove extra spaces
	datafiles="$(echo ${datafiles// })"

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
		die "Warning direct upgrade unsafe!"
	fi
	if has_version "<=dev-lang/perl-5.8.8_rc1" && built_with_use dev-lang/perl minimal ; then
		die "You must have a complete (USE='-minimal') Perl install to use the perl backend!"
	fi

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
		"${S}"/servers/slapd/Makefile.in

	# Fix up DB-4.0 linking problem
	# remember to autoconf! this expands configure by 500 lines (4 lines to m4
	# stuff).
	EPATCH_OPTS="-p1 -d ${S}" epatch "${PATCHDIR}"/${PN}-2.2.14-db40.patch

	# supersedes old fix for bug #31202
	EPATCH_OPTS="-p1 -d ${S}" epatch "${FILESDIR}"/${PN}-2.2.14-perlthreadsfix.patch

	# Security bug #96767
	# http://bugzilla.padl.com/show_bug.cgi?id=210
	EPATCH_OPTS="-p1 -d ${S}" epatch "${PATCHDIR}"/${PN}-2.2.26-tls-fix-connection-test.patch

	# ensure correct SLAPI path by default
	sed -i -e 's,\(#define LDAPI_SOCK\).*,\1 "/var/run/openldap/slapd.sock",' \
		"${S}"/include/ldap_defaults.h

	EPATCH_OPTS="-p0 -d ${S}" epatch "${FILESDIR}"/${PN}-2.2.6-ntlm.patch

	# fix up stuff for newer autoconf that simulates autoconf-2.13, but doesn't
	# do it perfectly.
	cd "${S}"/build
	ln -s shtool install
	ln -s shtool install.sh

	# make files ready for new autoconf
	EPATCH_OPTS="-p0 -d ${S}" epatch "${PATCHDIR}"/${PN}-2.1.30-autoconf25.patch

	# fix AC calls bug #114544
	EPATCH_OPTS="-p0 -d ${S}/build" epatch "${PATCHDIR}"/${PN}-2.1.30-m4_underquoted.patch

	# make tests rpath ready
	EPATCH_OPTS="-p0 -d ${S}/tests" epatch "${PATCHDIR}"/${PN}-2.2.28-tests.patch

	# make autoconf-archive compatible
	EPATCH_OPTS="-p0 -d ${S}" epatch "${PATCHDIR}"/${PN}-2.2.28-autoconf-archived-fix.patch

	# make autoconf-archive compatible
	EPATCH_OPTS="-p1 -d ${S}" epatch "${PATCHDIR}"/${PN}-2.1.30-glibc24.patch

	# add cleartext passwords backport bug #112554
	EPATCH_OPTS="-p0 -d ${S}" epatch "${PATCHDIR}"/${PN}-2.2.28-cleartext-passwords.patch

	# CVE-2006-5779, bug #154349
	EPATCH_OPTS="-p0 -d ${S}" epatch "${PATCHDIR}"/${PN}-2.3.27-CVE-2006-5779.patch

	# reconf for RPATH solve
	cd "${S}"
	libtoolize --copy --force --automake
	eaclocal || die "aclocal failed"
	EPATCH_OPTS="-p0 -d ${S}" epatch "${PATCHDIR}"/${PN}-2.1.30-rpath.patch
	eautoconf || die "autoconf failed"
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

	# Adding back -j1 as upstream didn't answer on parallel make issue yet
	emake -j1 depend || die "make depend failed"
	emake -j1 || die "make failed"

	# special kerberos stuff
	tc-export CC
	if ! use minimal && use kerberos ; then
		cd "${S}"/contrib/slapd-modules/passwd/ && \
		${CC} -shared -I../../../include ${CFLAGS} -fPIC \
		-DHAVE_KRB5 -o pw-kerberos.so kerberos.c || \
		die "failed to compile kerberos module"
	fi
}

src_test() {
	einfo "Doing tests"
	cd tests ; make tests || die "make tests failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc ANNOUNCEMENT CHANGES COPYRIGHT README LICENSE "${FILESDIR}"/DB_CONFIG.fast.example
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

	echo "OLDPF='${PF}'" >"${D}"${OPENLDAP_VERSIONTAG}
	echo "# do NOT delete this. it is used" >>"${D}"${OPENLDAP_VERSIONTAG}
	echo "# to track versions for upgrading." >>"${D}"${OPENLDAP_VERSIONTAG}

	# manually remove /var/tmp references in .la
	# because it is packaged with an ancient libtool
	for x in "${D}"usr/$(get_libdir)/lib*.la; do
		sed -i -e "s:-L${S}[/]*libraries::" ${x}
	done

	# change slapd.pid location in configuration file
	keepdir /var/run/openldap
	fowners ldap:ldap /var/run/openldap
	fperms 0755 /var/run/openldap

	if ! use minimal; then
		# config modifications
		for f in /etc/openldap/slapd.conf /etc/openldap/slapd.conf.default; do
			sed -e "s:/var/lib/run/slapd.:/var/run/openldap/slapd.:" -i "${D}"${f}
			sed -e "/database\tbdb$/acheckpoint	32	30 # <kbyte> <min>" -i "${D}"${f}
			fowners root:ldap ${f}
			fperms 0640 ${f}
		done

		# install our own init scripts
		newinitd "${FILESDIR}"/slapd-initd slapd
		newinitd "${FILESDIR}"/slurpd-initd slurpd
		newconfd "${FILESDIR}"/slapd-confd slapd

		if [ $(get_libdir) != lib ]; then
			sed -e "s,/usr/lib/,/usr/$(get_libdir)/," -i "${D}"etc/init.d/{slapd,slurpd}
		fi

		if use kerberos && [ -f "${S}"/contrib/slapd-modules/passwd/pw-kerberos.so ]; then
			insinto /usr/$(get_libdir)/openldap/openldap
			doins "${S}"/contrib/slapd-modules/passwd/pw-kerberos.so || \
			die "failed to install kerberos passwd module"
		fi
	fi
}

pkg_preinst() {
	# keep old libs if needed
	for each in liblber.so.2.0.130 libldap.so.2.0.130 libldap_r.so.2.0.130 ; do
		preserve_old_lib "${ROOT}usr/$(get_libdir)/${each}"
	done
}

pkg_postinst() {
	if use ssl && ! use minimal; then
		insinto /etc/openldap/ssl
		docert ldap
		ewarn "Self-signed SSL certificates are treated harshly by OpenLDAP 2.[12]"
		ewarn "add 'TLS_REQCERT never' if you want to use them."
	fi

	# Since moving to running openldap as user ldap there are some
	# permissions problems with directories and files.
	# Let's make sure these permissions are correct.
	chown ldap:ldap "${ROOT}"var/run/openldap
	chmod 0755 "${ROOT}"var/run/openldap
	chown root:ldap "${ROOT}"etc/openldap/slapd.conf{,.default}
	chmod 0640 "${ROOT}"etc/openldap/slapd.conf{,.default}
	chown ldap:ldap "${ROOT}"var/lib/openldap-{data,ldbm,slurp}

	# Reference inclusion bug #77330
	echo
	einfo "Getting started using OpenLDAP? There is some documentation available:"
	einfo "Gentoo Guide to OpenLDAP Authentication"
	einfo "(http://www.gentoo.org/doc/en/ldap-howto.xml)"

	# note to bug #110412
	echo
	einfo "An example file for tuning BDB backends with openldap is:"
	einfo "/usr/share/doc/${P}/DB_CONFIG.fast.example.gz"

	for each in liblber.so.2.0.130 libldap.so.2.0.130 libldap_r.so.2.0.130 ; do
		preserve_old_lib_notify "${ROOT}usr/$(get_libdir)/${each}"
	done
}
