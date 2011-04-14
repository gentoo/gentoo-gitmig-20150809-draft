# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/proftpd/proftpd-1.3.4_rc2-r1.ebuild,v 1.1 2011/04/14 19:02:59 voyageur Exp $

EAPI=4
inherit eutils autotools

MOD_CASE="0.4"
MOD_CLAMAV="0.11rc"
MOD_DISKUSE="0.9"
MOD_GSS="1.3.3"
MOD_VROOT="0.9.2"

DESCRIPTION="An advanced and very configurable FTP server."
HOMEPAGE="http://www.proftpd.org/
	http://www.castaglia.org/proftpd/
	http://www.thrallingpenguin.com/resources/mod_clamav.htm
	http://gssmod.sourceforge.net/"
SRC_URI="ftp://ftp.proftpd.org/distrib/source/${P/_/}.tar.bz2
	case? ( http://www.castaglia.org/${PN}/modules/${PN}-mod-case-${MOD_CASE}.tar.gz )
	clamav? ( https://secure.thrallingpenguin.com/redmine/attachments/download/1/mod_clamav-${MOD_CLAMAV}.tar.gz )
	diskuse? ( http://www.castaglia.org/${PN}/modules/${PN}-mod-diskuse-${MOD_DISKUSE}.tar.gz )
	kerberos? ( mirror://sourceforge/gssmod/mod_gss-${MOD_GSS}.tar.gz )
	vroot? ( http://www.castaglia.org/${PN}/modules/${PN}-mod-vroot-${MOD_VROOT}.tar.gz )"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~amd64-fbsd ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="acl authfile ban +caps case clamav copy ctrls deflate diskuse doc exec ifsession ifversion ident
	ipv6 kerberos ldap memcache mysql ncurses nls pam +pcre postgres qos radius ratio readme rewrite
	selinux sftp shaper sitemisc softquota sqlite ssl tcpd trace vroot xinetd"

DEPEND="acl? ( sys-apps/acl sys-apps/attr )
	caps? ( sys-libs/libcap )
	clamav? ( app-antivirus/clamav )
	kerberos? ( virtual/krb5 )
	ldap? ( net-nds/openldap )
	memcache? ( >=dev-libs/libmemcached-0.37 )
	mysql? ( virtual/mysql )
	nls? ( virtual/libiconv )
	ncurses? ( sys-libs/ncurses )
	pam? ( virtual/pam )
	pcre? ( dev-libs/libpcre )
	postgres? ( dev-db/postgresql-base )
	sftp? ( dev-libs/openssl )
	sqlite? ( dev-db/sqlite:3 )
	ssl? ( dev-libs/openssl )
	xinetd? ( virtual/inetd )"
RDEPEND="${DEPEND}
	net-ftp/ftpbase
	selinux? ( sec-policy/selinux-ftpd )"

S="${WORKDIR}/${P/_/}"

__prepare_module() {
	mv "${WORKDIR}"/$1/$1.c contrib
	mv "${WORKDIR}"/$1/$1.html doc/contrib
	rm -rf "${WORKDIR}"/$1
}

src_prepare() {
	# Gentoo bug #363293
	epatch "${FILESDIR}"/${P}-sql-groupsetfast-null-pointer.patch

	use case && __prepare_module mod_case
	if use clamav ; then
		mv "${WORKDIR}"/mod_clamav-${MOD_CLAMAV}/mod_clamav.{c,h} contrib
		epatch "${WORKDIR}"/mod_clamav-${MOD_CLAMAV}/${PN}.patch
		rm -rf "${WORKDIR}"/mod_clamav-${MOD_CLAMAV}
	fi
	use vroot && __prepare_module mod_vroot

	sed -i -e "s/utils install-conf install/utils install/g" Makefile.in
	sed -i -e "s/ @INSTALL_STRIP@//g" Make.rules.in

	# Support new versions of mit-krb5 (Gentoo Bugs #284853, #324903)
	if use kerberos ; then
		cd "${WORKDIR}"/mod_gss-${MOD_GSS}
		sed -i -e "s/krb5_principal2principalname/_\0/" mod_auth_gss.c.in
		sed -i -e "/ac_gss_libs/s/\-ldes425\ //" configure.in
		eautoreconf
	fi
}

src_configure() {
	local myc myl mym

	use acl && mym="${mym}:mod_facl"
	use ban && mym="${mym}:mod_ban"
	use case && mym="${mym}:mod_case"
	use clamav && mym="${mym}:mod_clamav"
	use copy && mym="${mym}:mod_copy"
	if use ctrls || use ban || use shaper ; then
		myc="${myc} --enable-ctrls"
		mym="${mym}:mod_ctrls_admin"
	fi
	use deflate && mym="${mym}:mod_deflate"
	if use diskuse ; then
		cd "${WORKDIR}"/mod_diskuse
		econf
		mv mod_diskuse.{c,h} "${S}"/contrib
		mv mod_diskuse.html "${S}"/doc/contrib
		cd "${S}"
		rm -rf "${WORKDIR}"/mod_diskuse
		mym="${mym}:mod_diskuse"
	fi
	use exec && mym="${mym}:mod_exec"
	use ifsession && mym="${mym}:mod_ifsession"
	use ifversion && mym="${mym}:mod_ifversion"
	if use kerberos ; then
		cd "${WORKDIR}"/mod_gss-${MOD_GSS}
		if has_version app-crypt/mit-krb5 ; then
			econf --enable-mit
		else
			econf --enable-heimdal
		fi
		mv mod_{auth_gss,gss}.c "${S}"/contrib
		mv mod_gss.h "${S}"/include
		mv README.mod_{auth_gss,gss} "${S}"
		mv mod_gss.html "${S}"/doc/contrib
		mv rfc{1509,2228}.txt "${S}"/doc/rfc
		cd "${S}"
		rm -rf "${WORKDIR}"/mod_gss-${MOD_GSS}
		mym="${mym}:mod_gss:mod_auth_gss"
	fi
	if use ldap ; then
		use elibc_glibc && myl="${myl} -lresolv"
		mym="${mym}:mod_ldap"
	fi
	if use mysql || use postgres || use sqlite ; then
		mym="${mym}:mod_sql:mod_sql_passwd"
		use mysql && mym="${mym}:mod_sql_mysql"
		use postgres && mym="${mym}:mod_sql_postgres"
		use sqlite && mym="${mym}:mod_sql_sqlite"
	fi
	use qos && mym="${mym}:mod_qos"
	use radius && mym="${mym}:mod_radius"
	use ratio && mym="${mym}:mod_ratio"
	use readme && mym="${mym}:mod_readme"
	use rewrite && mym="${mym}:mod_rewrite"
	use sftp || use ssl && myc="${myc} --enable-openssl"
	if use sftp ; then
		mym="${mym}:mod_sftp"
		use pam && mym="${mym}:mod_sftp_pam"
		use mysql || use postgres || use sqlite && mym="${mym}:mod_sftp_sql"
	fi
	use shaper && mym="${mym}:mod_shaper"
	use sitemisc && mym="${mym}:mod_site_misc"
	if use softquota ; then
		mym="${mym}:mod_quotatab:mod_quotatab_file"
		use ldap && mym="${mym}:mod_quotatab_ldap"
		use radius && mym="${mym}:mod_quotatab_radius"
		use mysql || use postgres || use sqlite && mym="${mym}:mod_quotatab_sql"
	fi
	if use ssl ; then
		mym="${mym}:mod_tls:mod_tls_shmcache"
		use memcache && mym="${mym}:mod_tls_memcache"
	fi
	if use tcpd ; then
		mym="${mym}:mod_wrap2:mod_wrap2_file"
		use mysql || use postgres || use sqlite && mym="${mym}:mod_wrap2_sql"
	fi
	use vroot && mym="${mym}:mod_vroot"

	[ -z ${mym} ] || myc="${myc} --with-modules=${mym:1}"
	LIBS="${myl:1}" econf --localstatedir=/var/run/proftpd --sysconfdir=/etc/proftpd \
		$(use_enable acl facl) \
		$(use_enable authfile auth-file) \
		$(use_enable caps cap) \
		$(use_enable ident) \
		$(use_enable ipv6) \
		$(use_enable memcache) \
		$(use_enable ncurses) \
		$(use_enable nls) \
		$(use_enable pam auth-pam) \
		$(use_enable pcre) \
		$(use_enable trace) \
		$(use_enable userland_GNU shadow) \
		$(use_enable userland_GNU autoshadow) \
		${myc:1}
}

src_install() {
	emake DESTDIR="${ED}" install
	newinitd "${FILESDIR}"/proftpd.initd proftpd
	insinto /etc/proftpd
	doins "${FILESDIR}"/proftpd.conf.sample

	if use xinetd ; then
		insinto /etc/xinetd.d
		newins "${FILESDIR}"/proftpd.xinetd proftpd
	fi

	dodoc ChangeLog CREDITS INSTALL NEWS README* RELEASE_NOTES
	if use doc ; then
		dohtml doc/*.html doc/contrib/*.html doc/howto/*.html doc/modules/*.html
		docinto rfc
		dodoc doc/rfc/*.txt
	fi
}

pkg_postinst() {
	if use exec ; then
		ewarn
		ewarn "ProFTPD has been built with the mod_exec module. This module"
		ewarn "can be a security risk for your server as it executes external"
		ewarn "programs. Vulnerables in these external programs may disclose"
		ewarn "information or even compromise your server."
		ewarn "You have been warned! Use this module at your own risk!"
		ewarn
	fi
	if use tcpd ; then
		ewarn
		ewarn "Important: Since ProFTPD 1.3.4rc2 the module mod_wrap for TCP Wrapper"
		ewarn "support has been replaced by mod_wrap2 which is more configurable and"
		ewarn "portable.  But you have to adjust your configuration before restaring"
		ewarn "ProFTPD. On the following website you can find more information:"
		ewarn "  http://proftpd.org/docs/contrib/mod_wrap2.html"
		ewarn
	fi
}
