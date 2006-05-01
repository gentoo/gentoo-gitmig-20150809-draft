# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/openldap/openldap-2.3.21.ebuild,v 1.7 2006/05/01 20:23:35 jokey Exp $

inherit autotools eutils flag-o-matic multilib toolchain-funcs

DESCRIPTION="LDAP suite of application and development tools"
HOMEPAGE="http://www.OpenLDAP.org/"
SRC_URI="mirror://openldap/openldap-release/${P}.tgz"

LICENSE="OPENLDAP"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="berkdb crypt debug gdbm ipv6 kerberos minimal odbc perl readline samba sasl slp ssl tcpd selinux"

# note that the 'samba' USE flag pulling in OpenSSL is NOT an error.  OpenLDAP
# uses OpenSSL for LanMan/NTLM hashing (which is used in some enviroments, like
# mine at work)!
# Robin H. Johnson <robbat2@gentoo.org> March 8, 2004

RDEPEND_BERKDB=">=sys-libs/db-4.2.52_p2-r1"
RDEPEND=">=sys-libs/ncurses-5.1
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	readline? ( >=sys-libs/readline-4.1 )
	sasl? ( >=dev-libs/cyrus-sasl-2.1.7-r3 )
	odbc? ( dev-db/unixODBC )
	slp? ( >=net-libs/openslp-1.0 )
	perl? ( >=dev-lang/perl-5.6 )
	samba? ( >=dev-libs/openssl-0.9.6 )
	kerberos? ( virtual/krb5 )
	berkdb? ( ${RDEPEND_BERKDB} )
	!berkdb? (
		gdbm? ( >=sys-libs/gdbm-1.8.0 )
		!gdbm? ( ${RDEPEND_BERKDB} )
	)
	selinux? ( sec-policy/selinux-openldap )"

DEPEND="${RDEPEND}
		>=sys-devel/libtool-1.5.18-r1
		>=sys-apps/sed-4"

# for tracking versions
OPENLDAP_VERSIONTAG=".version-tag"
OPENLDAP_DEFAULTDIR_VERSIONTAG="/var/lib/openldap-data/"

openldap_upgrade_howto() {
	eerror
	eerror "A (possible old) installation of OpenLDAP was detected,"
	eerror "installation will not proceed for now."
	eerror
	eerror "As major version upgrades can corrupt your database,"
	eerror "you need to dump your database and re-create it afterwards."
	eerror ""
	d="$(date -u +%s)"
	l="/root/ldapdump.${d}"
	i="${l}.raw"
	eerror " 1. /etc/init.d/slurpd stop ; /etc/init.d/slapd stop"
	eerror " 2. slapcat -l ${i}"
	eerror " 3. egrep -v '^entryCSN:' <${i} >${l}"
	eerror " 4. mv /var/lib/openldap-data/ /var/lib/openldap-data-backup/"
	eerror " 5. emerge --update \=net-nds/openldap-${PV}"
	eerror " 6. etc-update, and ensure that you apply the changes"
	eerror " 7. slapadd -l ${l}"
	eerror " 8. chown ldap:ldap /var/lib/openldap-data/*"
	eerror " 9. /etc/init.d/slapd start"
	eerror "10. check that your data is intact."
	eerror "11. set up the new replication system."
	eerror
	die "You need to upgrade your database first"
}

openldap_find_versiontags() {
	# scan for all datadirs
	openldap_datadirs=""
	if [ -f ${ROOT}/etc/openldap/slapd.conf ]; then
		openldap_datadirs="$(awk '{if($1 == "directory") print $2 }' ${ROOT}/etc/openldap/slapd.conf)"
	fi

	# scan datadirs if we have a version tag
	openldap_found_tag=0
	for each in ${openldap_datadirs}; do
		CURRENT_TAGDIR=${ROOT}`echo $each | sed "s:\/::"`
		CURRENT_TAG=${CURRENT_TAGDIR}/${OPENLDAP_VERSIONTAG}
		if [ -d ${CURRENT_TAGDIR} ] &&  [ ${openldap_found_tag} == 0 ] ; then
			if [ -s ${CURRENT_TAG} ] ; then
				# yey, we have one :)
				openldap_found_tag=1
				source ${CURRENT_TAG}
				OLD_PV=${OLDPF##*-}
				OLD_MAJOR=${OLD_PV:0:3}

				# are we on the same branch?
				if [ "${OLD_MAJOR}" != "${PV:0:3}" ] ; then
					openldap_upgrade_howto
				fi
			fi
		fi
	done

	# If we have no tag, scan dirs again to see if we have a populated database
	if [ ${openldap_found_tag} == 0 ] ; then
		for each in ${openldap_datadirs}; do
	    	        eachdir=${ROOT}`echo $each | sed "s:\/::"`
			if [ -d ${eachdir} ] ; then
				if [[ `ls -a ${eachdir} | wc -l` > 4 ]] ; then
					eerror
					eerror "Your OpenLDAP Installation has no tagged datadir but it"
					eerror "possibly contains a database at ${eachdir}"
					eerror
					eerror "Please export data if any entered and empty or remove"
					eerror "the directory, installation has been stopped so you"
					eerror "can take required action"
					eerror
					eerror "For a HOWTO on exporting the data, see instructions in the ebuild"
					eerror
					die "Please move the datadir ${eachdir} away"
				fi
			fi
		done
	fi
}

pkg_setup() {
	openldap_find_versiontags
	if use perl && built_with_use dev-lang/perl minimal ; then
		die "You must have a complete (USE='-minimal') Perl install to use the perl backend!"
	fi
}

pkg_preinst() {
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

	# supersedes old fix for bug #31202
	EPATCH_OPTS="-p1 -d ${S}" epatch ${FILESDIR}/${PN}-2.2.14-perlthreadsfix.patch

	# ensure correct SLAPI path by default
	sed -i -e 's,\(#define LDAPI_SOCK\).*,\1 "/var/run/openldap/slapd.sock",' \
		${S}/include/ldap_defaults.h

	# ximian connector 1.4.7 ntlm patch
	EPATCH_OPTS="-p0 -d ${S}" epatch ${FILESDIR}/${PN}-2.2.6-ntlm.patch

	# fix up stuff for newer autoconf that simulates autoconf-2.13, but doesn't
	# do it perfectly.
	cd ${S}/build
	ln -s shtool install
	ln -s shtool install.sh

}

src_compile() {
	local myconf

	# HDB is only available with BerkDB
	myconf_berkdb='--enable-bdb --with-ldbm-api=berkeley --enable-hdb=mod'
	myconf_gdbm='--disable-bdb --with-ldbm-api=gdbm --disable-hdb'

	use debug && myconf="${myconf} --enable-debug" # there is no disable-debug

	# enable slapd/slurpd servers if not doing a minimal build
	if ! use minimal ; then
		myconf="${myconf} --enable-slapd --enable-slurpd"
		# base backend stuff
		myconf="${myconf} --enable-ldbm"
		if use berkdb ; then
			einfo "Using Berkeley DB for local backend"
			myconf="${myconf} ${myconf_berkdb}"
		elif use gdbm ; then
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
}

src_test() {
	einfo
	einfo "Doing tests"
	einfo
	cd tests ; make tests || die "make tests failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc ANNOUNCEMENT CHANGES COPYRIGHT README LICENSE ${FILESDIR}/DB_CONFIG.fast.example
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

	echo "OLDPF='${PF}'" >${D}${OPENLDAP_DEFAULTDIR_VERSIONTAG}${OPENLDAP_VERSIONTAG}
	echo "# do NOT delete this. it is used" >>${D}${OPENLDAP_DEFAULTDIR_VERSIONTAG}${OPENLDAP_VERSIONTAG}
	echo "# to track versions for upgrading." >>${D}${OPENLDAP_DEFAULTDIR_VERSIONTAG}${OPENLDAP_VERSIONTAG}

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
		doexe ${FILESDIR}/gencert.sh
	fi

	# keep old libs if any
	# from 2.1
	for each in ${ROOT}usr/$(get_libdir)/liblber.so.2.0.1*; do
		preserve_old_lib ${each}
	done
	for each in ${ROOT}usr/$(get_libdir)/libldap.so.2.0.1*; do
		preserve_old_lib ${each}
	done
	for each in ${ROOT}usr/$(get_libdir)/libldap_r.so.2.0.1*; do
		preserve_old_lib ${each}
	done
	# from 2.2
	for each in ${ROOT}usr/$(get_libdir)/liblber-2.2*; do
		preserve_old_lib ${each}
	done
	for each in ${ROOT}usr/$(get_libdir)/libldap-2.2*; do
		preserve_old_lib ${each}
	done
	for each in ${ROOT}usr/$(get_libdir)/libldap_r-2.2*; do
		preserve_old_lib ${each}
	done
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
			einfo
			einfo "An LDAP cert already appears to exist, no creating"
			einfo
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
		ewarn
		ewarn "Self-signed SSL certificates are treated harshly by OpenLDAP 2.[12]"
		ewarn "add 'TLS_REQCERT never' if you want to use them."
		ewarn
	fi

	# Reference inclusion bug #77330
	echo
	einfo
	einfo "Getting started using OpenLDAP? There is some documentation available:"
	einfo "Gentoo Guide to OpenLDAP Authentication"
	einfo "(http://www.gentoo.org/doc/en/ldap-howto.xml)"
	einfo

	# note to bug #110412
	echo
	einfo
	einfo "An example file for tuning BDB backends with openldap is:"
	einfo "/usr/share/doc/${P}/DB_CONFIG.fast.example.gz"
	einfo

	# keep old libs if any
	# from 2.1
	for each in ${ROOT}usr/$(get_libdir)/liblber.so.2.0.1* ; do
		preserve_old_lib_notify ${each}
	done
	for each in ${ROOT}usr/$(get_libdir)/libldap.so.2.0.1* ; do
		preserve_old_lib_notify ${each}
	done
	for each in ${ROOT}usr/$(get_libdir)/libldap_r.so.2.0.1* ; do
		preserve_old_lib_notify ${each}
	done
	# from 2.2
	for each in ${ROOT}usr/$(get_libdir)/liblber-2.2* ; do
		preserve_old_lib_notify ${each}
	done
	for each in ${ROOT}usr/$(get_libdir)/libldap-2.2* ; do
		preserve_old_lib_notify ${each}
	done
	for each in ${ROOT}usr/$(get_libdir)/libldap_r-2.2* ; do
		preserve_old_lib_notify ${each}
	done
}
