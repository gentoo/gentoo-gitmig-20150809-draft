# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/openldap/openldap-2.2.24.ebuild,v 1.1 2005/03/21 01:04:19 robbat2 Exp $

inherit toolchain-funcs eutils

DESCRIPTION="LDAP suite of application and development tools"
HOMEPAGE="http://www.OpenLDAP.org/"
SRC_URI="mirror://openldap/openldap-release/${P}.tgz"

LICENSE="OPENLDAP"
SLOT="0"
IUSE="berkdb crypt debug gdbm ipv6 kerberos odbc perl readline samba sasl slp ssl tcpd"
#In portage for testing only, hardmasked in package.mask
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~amd64 ~s390 ~hppa ~ppc64 ~ia64"

DEPEND=">=sys-libs/ncurses-5.1
	>=sys-apps/sed-4
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
DEPEND_BERKDB=">=sys-libs/db-4.2.52_p1"
DEPEND_GDBM=">=sys-libs/gdbm-1.8.0"
DEPEND="${DEPEND}
	berkdb? ( ${DEPEND_BERKDB} )
	!berkdb? (
		gdbm? ( ${DEPEND_GDBM} )
		!gdbm? ( ${DEPEND_BERKDB} )
	)"

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
}

pkg_setup() {
	# grab lines
	openldap_datadirs="$(awk '{if($1 == "directory") print $2 }' /etc/openldap/slapd.conf)"
	datafiles=""
	for d in $openldap_datadirs; do
		datafiles="${datafiles} $(ls $d/*{bdb,gdbm} 2>/dev/null)"
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
		exit 1
	fi
	openldap_upgrade_warning
}

pkg_preinst() {
	openldap_upgrade_warning
	enewgroup ldap 439
	enewuser ldap 439 /bin/false /usr/lib/openldap ldap
}

src_unpack() {
	unpack ${A}

	# According to MDK, the link order needs to be changed so that
	# on systems w/ MD5 passwords the system crypt library is used
	# (the net result is that "passwd" can be used to change ldap passwords w/
	#  proper pam support)
	sed -ie 's/$(SECURITY_LIBS) $(LDIF_LIBS) $(LUTIL_LIBS)/$(LUTIL_LIBS) $(SECURITY_LIBS) $(LDIF_LIBS)/' \
		${S}/servers/slapd/Makefile.in

	# Fix up DB-4.0 linking problem
	# remember to autoconf! this expands configure by 500 lines (4 lines to m4
	# stuff).
	EPATCH_OPTS="-p1 -d ${S}" epatch ${FILESDIR}/${PN}-2.2.14-db40.patch

	# supersedes old fix for bug #31202
	EPATCH_OPTS="-p1 -d ${S}" epatch ${FILESDIR}/${PN}-2.2.14-perlthreadsfix.patch

	# fix up stuff for newer autoconf that simulates autoconf-2.13, but doesn't
	# do it perfectly.
	cd ${S}/build
	ln -s shtool install
	ln -s shtool install.sh

	# reconf for db40 fixes.
	cd ${S}
	WANT_AUTOCONF="2.1" autoconf
}

src_compile() {
	local myconf

	myconf="${myconf} --enable-ldbm"
	# HDB is only available with BerkDB
	myconf_berkdb='--enable-bdb --with-ldbm-api=berkeley --enable-hdb=mod'
	myconf_gdbm='--disable-bdb --with-ldbm-api=gdbm --disable-hdb'
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


	# enable slapd/slurpd servers
	myconf="${myconf} --enable-ldap"
	myconf="${myconf} --enable-slapd --enable-slurpd"
	# basic stuff
	myconf="${myconf} --enable-syslog"
	use debug && myconf="${myconf} --enable-debug" # there is no disable-debug
	# extra functionality
	myconf="${myconf} --enable-dynamic --enable-modules"
	myconf="${myconf} --enable-rewrite --enable-rlookups"
	myconf="${myconf} --enable-passwd=mod --enable-phonetic=mod"
	myconf="${myconf} --enable-dnssrv=mod --enable-ldap"
	myconf="${myconf} --enable-meta=mod --enable-monitor=mod"
	myconf="${myconf} --enable-null=mod --enable-shell=mod"
	myconf="${myconf} --enable-local --enable-proctitle"
	myconf="${myconf} --enable-dyngroup"
	myconf="${myconf} --enable-aci --enable-proxycache"
	myconf="${myconf} --enable-cleartext --enable-slapi"

	# disabled options:
	# --with-bdb-module=dynamic
	# alas, for BSD only:
	# --with-fetch

	for i in crypt ipv6 slp readline; do
		myconf="${myconf} `use_enable ${i}`"
	done

	for i in perl sql odbc,sql; do
		m="${i/*,}"
		useq ${i/,*} && m="enable-${m}=mod" || m="disable-${m}"
		myconf="${myconf} --${m}"
	done
	myconf="${myconf} `use_with sasl cyrus-sasl` `use_enable sasl spasswd`"
	myconf="${myconf} `use_enable tcpd wrappers`"
	myconf="${myconf} `use_with ssl tls` `use_with samba lmpasswd`"

	econf \
		--enable-static \
		--enable-shared \
		--libexecdir=/usr/lib/openldap \
		${myconf} || die "configure failed"

	make depend || die "make depend failed"
	make || die "make failed"

	tc-export CC
	if useq kerberos ; then
		cd ${S}/contrib/slapd-modules/passwd/
		${CC} -shared -I../../../include ${CFLAGS} -DHAVE_KRB5 -o pw-kerberos.so kerberos.c
	fi
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
	keepdir /usr/lib/openldap/openldap/

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
	for x in ${D}/usr/lib/lib*.la; do
		sed -i -e "s:-L${S}[/]*libraries::" ${x}
	done

	# change slapd.pid location in configuration file
	keepdir /var/run/openldap
	fowners ldap:ldap /var/run/openldap
	fperms 0755 /var/run/openldap
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
	insinto /etc/conf.d
	newins ${FILESDIR}/2.0/slapd.conf slapd

	# install MDK's ssl cert script
	if use ssl || use samba; then
		dodir /etc/openldap/ssl
		exeinto /etc/openldap/ssl
		doexe ${FILESDIR}/gencert.sh
	fi

	if useq kerberos ; then
		insinto /usr/lib/openldap/openldap
		doins ${S}/contrib/slapd-modules/passwd/pw-kerberos.so
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
	chown ldap:ldap /var/lib/openldap-{data,ldbm,slurp}

	if use ssl; then
		ewarn "Self-signed SSL certificates are treated harshly by OpenLDAP 2.[12]"
		ewarn "add 'TLS_REQCERT never' if you want to use them."
	fi
	openldap_upgrade_warning
}
