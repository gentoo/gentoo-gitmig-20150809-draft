# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/freeradius/freeradius-0.9.3-r1.ebuild,v 1.7 2004/07/14 22:53:05 agriffis Exp $

inherit eutils

IUSE="frascend frlargefiles frnothreds frxp kerberos ldap mysql pam postgres snmp ssl"

DESCRIPTION="highly configurable free RADIUS server"
SRC_URI="ftp://ftp.freeradius.org/pub/radius/${P}.tar.gz"
HOMEPAGE="http://www.freeradius.org/"
KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/libc
	sys-devel/libtool
	>=sys-libs/db-3.2
	sys-libs/gdbm
	snmp? ( virtual/snmp )
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )
	pam? ( sys-libs/pam )
	ssl? ( dev-libs/openssl )
	ldap? ( net-nds/openldap )
	kerberos? ( app-crypt/mit-krb5 )
	frxp? ( dev-lang/python
			dev-lang/perl )"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}

	epatch ${FILESDIR}/${P}-rlm_smb.patch

	export WANT_AUTOCONF=2.1
	autoconf
}

src_compile() {
	local myconf=""

	if ! use snmp; then
		myconf="--without-snmp"
	fi
	if use frascend; then
		myconf="${myconf} --with-ascend-binary"
	fi
	if use frlargefiles; then
		myconf="${myconf} --with-large-files"
	fi
	if use frnothreds; then
		myconf="${myconf} --without-threads"
	fi
	if use frxp; then
		myconf="${myconf} --with-experimental-modules"
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

	# experimental modules are
	# rlm_checkval rlm_cram rlm_dictionary rlm_example rlm_passwd rlm_perl
	# rlm_python rlm_smb rlm_sqlcounter

	./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var \
		--mandir=/usr/share/man --host=${CHOST} \
		--with-gnu-ld --with-system-libtool --disable-ltdl-install \
		${myconf} || die

	make || die
}

src_install() {
	dodir /etc/raddb

	make R=${D} install || die

	dodoc COPYRIGHT CREDITS INSTALL LICENSE README

	rm ${D}/usr/sbin/rc.radiusd

	dodir /etc/init.d
	cp ${FILESDIR}/0.9/radius.init ${D}/etc/init.d/radiusd

	dodir /etc/conf.d
	cp ${FILESDIR}/0.9/radius.conf ${D}/etc/conf.d/radiusd

	keepdir /var/run/radiusd
	keepdir /var/log/radius
	keepdir /var/log/radius/radacct
}

pkg_postinst() {
	einfo "You need to add an user and a group radiusd or"
	einfo "change the radiusd.conf file to use an existing"
	einfo "user for running radiusd."
	einfo "Make sure that all paths radiusd needs to write"
	einfo "to have the proper owner!"
}
