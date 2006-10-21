# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/freeradius/freeradius-1.1.3-r1.ebuild,v 1.1 2006/10/21 07:32:50 mrness Exp $

inherit eutils flag-o-matic multilib

DESCRIPTION="highly configurable free RADIUS server"
SRC_URI="ftp://ftp.freeradius.org/pub/radius/${P}.tar.gz"
HOMEPAGE="http://www.freeradius.org/"

KEYWORDS="amd64 ~ppc ~sparc x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="debug edirectory frascend frnothreads frxp kerberos ldap mysql pam postgres snmp ssl udpfromto"

DEPEND="!net-dialup/cistronradius
	!net-dialup/gnuradius
	>=sys-libs/db-3.2
	sys-libs/gdbm
	dev-lang/perl
	snmp? ( net-analyzer/net-snmp )
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )
	pam? ( sys-libs/pam )
	ssl? ( dev-libs/openssl )
	ldap? ( net-nds/openldap )
	kerberos? ( virtual/krb5 )
	frxp? ( dev-lang/python )"

pkg_setup() {
	if use edirectory && ! use ldap ; then
		eerror "Cannot add integration with Novell's eDirectory without having LDAP support!"
		eerror "Either you select ldap USE flag or remove edirectory"
		die "edirectory needs ldap"
	fi
	enewgroup radiusd
	enewuser radiusd -1 -1 /var/log/radius radiusd

	#TODO: Remove this function 6 months after all <1.1.1-r1 versions 
	#      has been removed from the tree.
	if cd "${ROOT}/usr/lib" ; then
		einfo "Cleaning up lefovers from previous versions..."

		local la_prefix file
		for la_prefix in libradius libeap rlm_acct_unique rlm_always rlm_attr_filter rlm_attr_rewrite \
			rlm_chap rlm_checkval rlm_counter rlm_cram rlm_dbm rlm_detail rlm_digest rlm_eap rlm_eap_gtc \
			rlm_eap_leap rlm_eap_md5 rlm_eap_mschapv2 rlm_eap_peap rlm_eap_sim rlm_eap_tls rlm_eap_ttls \
			rlm_example rlm_exec rlm_expr rlm_fastusers rlm_files rlm_ippool rlm_krb5 rlm_ldap rlm_mschap \
			rlm_ns_mta_md5 rlm_otp rlm_pam rlm_pap rlm_passwd rlm_perl rlm_preprocess rlm_python rlm_radutmp \
			rlm_realm rlm_sim_files rlm_smb rlm_sql rlm_sqlcounter rlm_sql_log rlm_unix ; do
				for file in ${la_prefix}-{0.8.1,0.9.0,0.9.3,1.0.1,1.0.2,1.0.4,1.0.5,1.1.0,1.1.1}.la ; do
					if [ -f "${file}" ] ; then
						rm "${file}"
					fi
				done
		done
	fi
}

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-versionless-la-files.patch"
	epatch "${FILESDIR}/${P}-nostrip.patch"
}

src_compile() {
	autoconf || die "autoconf failed"

	local myconf=" \
		`use_enable debug developer` \
		`use_with snmp` \
		`use_with frascend ascend-binary` \
		`use_with frxp experimental-modules` \
		`use_with udpfromto` \
		`use_with edirectory edir` "

	if useq frnothreads; then
		myconf="${myconf} --without-threads"
	fi
	#fix bug #77613
	if has_version app-crypt/heimdal; then
		myconf="${myconf} --enable-heimdal-krb5"
	fi

	# kill modules we don't use
	if ! use ssl; then
		einfo "removing rlm_eap_tls and rlm_x99_token (no use ssl)"
		rm -rf src/modules/rlm_eap/types/rlm_eap_tls src/modules/rlm_x99_token
	fi
	if ! use ldap; then
		einfo "removing rlm_ldap (no use ldap)"
		rm -rf src/modules/rlm_ldap
	fi
	if ! use kerberos; then
		einfo "removing rlm_krb5 (no use kerberos)"
		rm -rf src/modules/rlm_krb5
	fi
	if ! use pam; then
		einfo "removing rlm_pam (no use pam)"
		rm -rf src/modules/rlm_pam
	fi

	./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var \
		--mandir=/usr/share/man --libdir=/usr/$(get_libdir) \
		--with-large-files --disable-ltdl-install --with-pic \
		${myconf} || die "configure failed"

	make || die "make failed"
}

src_install() {
	dodir /etc
	dodir /var/log
	dodir /var/run
	diropts -m0750 -o root -g radiusd
	dodir /etc/raddb
	diropts -m0750 -o radiusd -g radiusd
	dodir /var/log/radius
	keepdir /var/log/radius/radacct
	dodir /var/run/radiusd
	diropts

	make R="${D}" install || die "make install failed"
	dosed 's:^#user *= *nobody:user = radiusd:;s:^#group *= *nobody:group = radiusd:' \
	    /etc/raddb/radiusd.conf
	chown -R root:radiusd "${D}"/etc/raddb/*

	mv "${D}/usr/share/doc/${PN}" "${D}/usr/share/doc/${PF}"
	gzip -f -9 "${D}/usr/share/doc/${PF}"/{rfc/*.txt,*}
	dodoc CREDITS

	rm "${D}/usr/sbin/rc.radiusd"

	newinitd "${FILESDIR}/radius.init" radiusd
	newconfd "${FILESDIR}/radius.conf" radiusd
}

pkg_preinst() {
	enewgroup radiusd
	enewuser radiusd -1 -1 /var/log/radius radiusd
}

pkg_prerm() {
	if [ "${ROOT}" = "/" ] && /etc/init.d/radiusd --quiet status ; then
		/etc/init.d/radiusd stop
	fi
}

pkg_postrm() {
	if [ "${ROOT}" = "/" ]; then
		ewarn "If radiusd service was running, it had been stopped!"
		echo
		ewarn "You should update the configuration files using etc-update or dispatch-conf"
		ewarn "and start the radiusd service again by running:"
		einfo "    /etc/init.d/radiusd start"

		ebeep
	fi
	ewarn "Auth-Type := Sql is no longer valid in /etc/raddb/users file!"
	ewarn "You should replace it with Auth-Type := Local."
}
