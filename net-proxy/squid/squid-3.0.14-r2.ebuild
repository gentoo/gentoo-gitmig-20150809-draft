# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/squid/squid-3.0.14-r2.ebuild,v 1.3 2009/05/11 17:17:30 ranger Exp $

EAPI="2"
WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit eutils pam toolchain-funcs autotools linux-info

# lame archive versioning scheme..
S_PMV="${PV%%.*}"
S_PV="${PV%.*}"
S_PL="${PV##*.}"
S_PP="${PN}-${S_PV}.STABLE${S_PL}"

RESTRICT="test" # check if test works in next bump

DESCRIPTION="A full-featured web proxy cache"
HOMEPAGE="http://www.squid-cache.org/"
SRC_URI="http://www.squid-cache.org/Versions/v${S_PMV}/${S_PV}/${S_PP}.tar.gz
	mirror://gentoo/${P}-chunk-encoding.patch.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="pam ldap samba sasl kerberos nis radius ssl snmp selinux icap-client logrotate \
	mysql postgres sqlite \
	zero-penalty-hit \
	pf-transparent ipf-transparent kqueue \
	elibc_uclibc kernel_linux epoll"

DEPEND="pam? ( virtual/pam )
	ldap? ( net-nds/openldap )
	kerberos? ( || ( app-crypt/mit-krb5 app-crypt/heimdal ) )
	ssl? ( dev-libs/openssl )
	sasl? ( dev-libs/cyrus-sasl )
	selinux? ( sec-policy/selinux-squid )
	!x86-fbsd? ( logrotate? ( app-admin/logrotate ) )
	>=sys-libs/db-4
	dev-lang/perl"
RDEPEND="${DEPEND}
	samba? ( net-fs/samba )
	mysql? ( dev-perl/DBD-mysql )
	postgres? ( dev-perl/DBD-Pg )
	sqlite? ( dev-perl/DBD-SQLite )"

S="${WORKDIR}/${S_PP}"

pkg_setup() {
	if grep -qs '^[[:space:]]*cache_dir[[:space:]]\+coss' "${ROOT}"etc/squid/squid.conf; then
		eerror "coss store IO has been disabled by upstream due to stability issues!"
		eerror "If you want to install this version, switch the store type to something else"
		eerror "before attempting to install this version again."

		die "/etc/squid/squid.conf: cache_dir use a disabled store type"
	fi

	enewgroup squid 31
	enewuser squid 31 -1 /var/cache/squid squid
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
	epatch "${FILESDIR}"/${P}-max-forwards.patch
	epatch "${FILESDIR}"/${P}-gcc43.patch
	epatch "${FILESDIR}"/${P}-cross-compile.patch
	epatch "${WORKDIR}"/${P}-chunk-encoding.patch
	use zero-penalty-hit && epatch "${FILESDIR}"/${P}-adapted-zph.patch
	has_version app-crypt/mit-krb5 || epatch "${FILESDIR}"/${P}-heimdal.patch

	eautoreconf
}

src_configure() {
	local basic_modules="getpwnam,NCSA,MSNT"
	use samba && basic_modules="SMB,multi-domain-NTLM,${basic_modules}"
	use ldap && basic_modules="LDAP,${basic_modules}"
	use pam && basic_modules="PAM,${basic_modules}"
	use sasl && basic_modules="SASL,${basic_modules}"
	use nis && ! use elibc_uclibc && basic_modules="YP,${basic_modules}"
	use radius && basic_modules="squid_radius_auth,${basic_modules}"
	if use mysql || use postgres || use sqlite ; then
		basic_modules="DB,${basic_modules}"
	fi

	local ext_helpers="ip_user,session,unix_group"
	use samba && ext_helpers="wbinfo_group,${ext_helpers}"
	use ldap && ext_helpers="ldap_group,${ext_helpers}"

	local ntlm_helpers="fakeauth"
	use samba && ntlm_helpers="SMB,${ntlm_helpers}"

	local negotiate_helpers=
	use kerberos && local negotiate_helpers="squid_kerb_auth"

	local myconf=""

	# coss support has been disabled
	# If it is re-enabled again, make sure you don't enable it for elibc_uclibc (#61175)
	myconf="${myconf} --enable-storeio=ufs,diskd,aufs,null"

	if use kernel_linux; then
		myconf="${myconf} --enable-linux-netfilter
			$(use_enable epoll)"
	elif use kernel_FreeBSD || use kernel_OpenBSD || use kernel_NetBSD ; then
		myconf="${myconf} $(use_enable kqueue)"
		if use pf-transparent; then
			myconf="${myconf} --enable-pf-transparent"
		elif use ipf-transparent; then
			myconf="${myconf} --enable-ipf-transparent"
		fi
	fi

	export CC=$(tc-getCC)

	econf \
		--sysconfdir=/etc/squid \
		--libexecdir=/usr/libexec/squid \
		--localstatedir=/var \
		--datadir=/usr/share/squid \
		--with-default-user=squid \
		--enable-auth="basic,digest,negotiate,ntlm" \
		--enable-removal-policies="lru,heap" \
		--enable-digest-auth-helpers="password" \
		--enable-basic-auth-helpers="${basic_modules}" \
		--enable-external-acl-helpers="${ext_helpers}" \
		--enable-ntlm-auth-helpers="${ntlm_helpers}" \
		--enable-negotiate-auth-helpers="${negotiate_helpers}" \
		--enable-useragent-log \
		--enable-cache-digests \
		--enable-delay-pools \
		--enable-referer-log \
		--enable-arp-acl \
		--with-large-files \
		--with-filedescriptors=8192 \
		$(use_enable snmp) \
		$(use_enable ssl) \
		$(use_enable icap-client) \
		${myconf} || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# need suid root for looking into /etc/shadow
	fowners root:squid /usr/libexec/squid/ncsa_auth
	fowners root:squid /usr/libexec/squid/pam_auth
	fperms 4750 /usr/libexec/squid/ncsa_auth
	fperms 4750 /usr/libexec/squid/pam_auth

	# some cleanups
	rm -f "${D}"/usr/bin/Run*

	dodoc CONTRIBUTORS CREDITS ChangeLog QUICKSTART SPONSORS doc/*.txt \
		helpers/ntlm_auth/no_check/README.no_check_ntlm_auth
	newdoc helpers/basic_auth/SMB/README README.auth_smb
	dohtml helpers/basic_auth/MSNT/README.html RELEASENOTES.html
	newdoc helpers/basic_auth/LDAP/README README.auth_ldap
	doman helpers/basic_auth/LDAP/*.8
	dodoc helpers/basic_auth/SASL/squid_sasl_auth*

	newpamd "${FILESDIR}/squid.pam" squid
	newconfd "${FILESDIR}/squid.confd" squid
	if use logrotate; then
		newinitd "${FILESDIR}/squid.initd-logrotate" squid
		insinto /etc/logrotate.d
		newins "${FILESDIR}/squid.logrotate" squid
	else
		newinitd "${FILESDIR}/squid.initd" squid
		exeinto /etc/cron.weekly
		newexe "${FILESDIR}/squid.cron" squid.cron
	fi

	rm -rf "${D}"/var
	diropts -m0755 -o squid -g squid
	keepdir /var/cache/squid /var/log/squid
}

pkg_postinst() {
	echo
	ewarn "Squid authentication helpers have been installed suid root."
	ewarn "This allows shadow based authentication (see bug #52977 for more)."
	echo
	ewarn "Be careful what type of cache_dir you select!"
	ewarn "   'diskd' is optimized for high levels of traffic, but it might seem slow"
	ewarn "when there isn't sufficient traffic to keep squid reasonably busy."
	ewarn "   If your traffic level is low to moderate, use 'aufs' or 'ufs'."
	echo
	ewarn "Squid can be configured to run in transparent mode like this:"
	ewarn "   ${HILITE}http_port internal-addr:3128 transparent${NORMAL}"
	if use zero-penalty-hit; then
		echo
		ewarn "In order for zph_preserve_miss_tos to work, you will have to alter your kernel"
		ewarn "with the patch that can be found on http://zph.bratcheda.org site."
	fi
}
