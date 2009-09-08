# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/proftpd/proftpd-1.3.3_rc1.ebuild,v 1.1 2009/09/08 16:27:17 voyageur Exp $

EAPI="2"
inherit autotools eutils

CASE_VER="0.3"
CLAMAV_VER="0.11rc"
DEFLATE_VER="0.3.3"
GSS_VER="1.3.2"
VROOT_VER="0.8.5"

DESCRIPTION="An advanced and very configurable FTP server."
HOMEPAGE="http://www.proftpd.org/
	http://www.castaglia.org/proftpd/
	http://www.thrallingpenguin.com/resources/mod_clamav.htm
	http://gssmod.sourceforge.net/"
SRC_URI="ftp://ftp.proftpd.org/distrib/source/${P/_/}.tar.bz2
	case? ( http://www.castaglia.org/${PN}/modules/${PN}-mod-case-${CASE_VER}.tar.gz )
	clamav? ( https://secure.thrallingpenguin.com/redmine/attachments/download/1/mod_clamav-${CLAMAV_VER}.tar.gz )
	deflate? ( http://www.castaglia.org/${PN}/modules/${PN}-mod-deflate-${DEFLATE_VER}.tar.gz )
	kerberos? ( mirror://sourceforge/gssmod/mod_gss-${GSS_VER}.tar.gz )
	vroot? ( http://www.castaglia.org/${PN}/modules/${PN}-mod-vroot-${VROOT_VER}.tar.gz )"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="acl authfile ban +caps case clamav ctrls deflate doc exec hardened ifsession +ident ipv6 kerberos ldap mysql ncurses nls pam postgres radius ratio readme rewrite selinux sftp shaper sitemisc softquota +ssl tcpd trace vroot xinetd"

DEPEND="acl? ( sys-apps/acl sys-apps/attr )
	caps? ( sys-libs/libcap )
	clamav? ( app-antivirus/clamav )
	kerberos? ( || ( <app-crypt/mit-krb5-1.7 app-crypt/heimdal ) )
	ldap? ( net-nds/openldap )
	mysql? ( virtual/mysql )
	ncurses? ( sys-libs/ncurses )
	sftp? ( dev-libs/openssl )
	ssl? ( dev-libs/openssl )
	pam? ( virtual/pam )
	postgres? ( virtual/postgresql-base )
	tcpd? ( sys-apps/tcp-wrappers )
	xinetd? ( virtual/inetd )"
RDEPEND="${DEPEND}
	net-ftp/ftpbase
	selinux? ( sec-policy/selinux-ftpd )"

S="${WORKDIR}/${P/_/}"

__prepare_plugin() {
	mv "${WORKDIR}"/$1/$1.c contrib
	mv "${WORKDIR}"/$1/$1.html doc/contrib
	rm -rf "${WORKDIR}"/$1
}

src_prepare() {
	use case && __prepare_plugin mod_case
	if use clamav ; then
		mv "${WORKDIR}"/mod_clamav-${CLAMAV_VER}/mod_clamav.{c,h} contrib
		epatch "${WORKDIR}"/mod_clamav-${CLAMAV_VER}/${PN}.patch
		rm -rf "${WORKDIR}"/mod_clamav-${CLAMAV_VER}
	fi
	use deflate && __prepare_plugin mod_deflate
	use vroot && __prepare_plugin mod_vroot

	# Fix MySQL includes
	sed -i -e "s/<mysql.h>/<mysql\/mysql.h>/g" contrib/mod_sql_mysql.c

	# Manipulate build system
	sed -i -e "s/utils install-conf install/utils install/g" Makefile.in
	sed -i -e "s/ @INSTALL_STRIP@//g" Make.rules.in
	sed -e "/libtool\.m4/q" aclocal.m4 > acinclude.m4
	rm -f aclocal.m4
	eautoreconf
}

src_configure() {
	local myconf mylibs mymodules

	use acl && mymodules="${mymodules}:mod_facl"
	use ban && mymodules="${mymodules}:mod_ban"
	use case && mymodules="${mymodules}:mod_case"
	use clamav && mymodules="${mymodules}:mod_clamav"
	use ctrls && mymodules="${mymodules}:mod_ctrls_admin"
	use deflate && mymodules="${mymodules}:mod_deflate"
	use exec && mymodules="${mymodules}:mod_exec"
	if use kerberos ; then
		cd "${WORKDIR}"/mod_gss-${GSS_VER}
		if has_version app-crypt/mit-krb5 ; then
			econf --enable-mit
		else
			econf --enable-heimdal
		fi
		mv mod_{auth_gss,gss}.c "${S}"/contrib
		mv mod_gss.h "${S}"/include
		mv README.mod_{authgss,gss} "${S}"
		mv mod_gss.html "${S}"/doc/contrib
		mv rfc{1509,2228}.txt "${S}"/doc/rfc
		cd "${S}"
		rm -rf "${WORKDIR}"/mod_gss-${GSS_VER}
		mymodules="${mymodules}:mod_gss:mod_auth_gss"
	fi
	if use ldap ; then
		mylibs="${mylibs} -lresolv"
		mymodules="${mymodules}:mod_ldap"
	fi
	if use mysql || use postgres ; then
		mymodules="${mymodules}:mod_sql"
		if use mysql ; then
			myconf="${myconf} --with-includes=/usr/include/mysql"
			mymodules="${mymodules}:mod_sql_mysql"
		fi
		if use postgres ; then
			myconf="${myconf} --with-includes=/usr/include/postgresql"
			mymodules="${mymodules}:mod_sql_postgres"
		fi
	fi
	if use ssl || use sftp; then
		CFLAGS="${CFLAGS} -DHAVE_OPENSSL"
		myconf="${myconf} --with-includes=/usr/include/openssl"
		myconf="${myconf} --enable-openssl"
		mylibs="${mylibs} -lcrypto"
	fi
	use radius && mymodules="${mymodules}:mod_radius"
	use ratio && mymodules="${mymodules}:mod_ratio"
	use readme && mymodules="${mymodules}:mod_readme"
	use rewrite && mymodules="${mymodules}:mod_rewrite"
	if use sftp ; then
		mymodules="${mymodules}:mod_sftp"
		use pam && mymodules="${mymodules}:mod_sftp_pam"
		if use mysql || use postgres ; then
			mymodules="${mymodules}:mod_sftp_sql"
		fi
	fi
	use shaper && mymodules="${mymodules}:mod_shaper"
	use sitemisc && mymodules="${mymodules}:mod_site_misc"
	if use softquota ; then
		mymodules="${mymodules}:mod_quotatab:mod_quotatab_file"
		use ldap && mymodules="${mymodules}:mod_quotatab_ldap"
		use radius && mymodules="${mymodules}:mod_quotatab_radius"
		if use mysql || use postgres ; then
			mymodules="${mymodules}:mod_quotatab_sql"
		fi
	fi
	use ssl && mymodules="${mymodules}:mod_tls:mod_tls_shmcache"
	use tcpd && mymodules="${mymodules}:mod_wrap"
	use vroot && mymodules="${mymodules}:mod_vroot"
	# mod_ifsession needs to be the last module in the mymodules list.
	use ifsession && mymodules="${mymodules}:mod_ifsession"

	[ ! -z ${mymodules} ] && myconf="${myconf} --with-modules=${mymodules:1}"
	LIBS="${mylibs}" econf --sbindir=/usr/sbin --localstatedir=/var/run/proftpd \
		--sysconfdir=/etc/proftpd --enable-shadow --enable-autoshadow \
		--enable-ctrls \
		$(use_enable acl facl) \
		$(use_enable authfile auth-file) \
		$(use_enable caps cap) \
		$(use_enable ident) \
		$(use_enable ipv6) \
		$(use_enable ncurses) \
		$(use_enable nls) \
		$(use_enable trace) \
		$(use_enable pam auth-pam) \
		${myconf} || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	keepdir /var/run/proftpd
	newinitd "${FILESDIR}"/proftpd.rc7 proftpd
	if use xinetd ; then
		insinto /etc/xinetd.d
		newins "${FILESDIR}"/proftpd.xinetd proftpd
	fi
	insinto /etc/proftpd
	doins "${FILESDIR}"/proftpd.conf.sample

	dodoc ChangeLog CREDITS INSTALL NEWS README* RELEASE_NOTES
	if use doc ; then
		dohtml doc/*.html doc/contrib/*.html doc/howto/*.html doc/modules/*.html
		docinto rfc
		dodoc doc/rfc/*.txt
	fi
}

pkg_postinst() {
	if use mysql && use postgres ; then
		elog "ProFTPD has been built with the MySQL and PostgreSQL modules."
		elog "You can use the 'SQLBackend' directive to specify the used SQL"
		elog "backend. Without this directive the default backend is MySQL."
	fi
	if use exec; then
		ewarn "You have enabled the mod_exec module. This can be a security risk,"
		ewarn "as detailed in documentation:"
		ewarn "Use of this module allows for such external programs to be executed, and also"
		ewarn "opens up the server to the mentioned possibilities of compromise or disclosure"
		ewarn "via those programs."
		ewarn "YOU HAVE BEEN WARNED"
		ewarn "USE AT YOUR OWN RISK"
	fi
}
