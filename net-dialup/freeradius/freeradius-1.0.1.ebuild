# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/freeradius/freeradius-1.0.1.ebuild,v 1.4 2004/10/17 09:28:51 dholm Exp $

inherit eutils

IUSE="frascend frnothreads frxp kerberos ldap mysql pam postgres snmp ssl"

DESCRIPTION="highly configurable free RADIUS server"
SRC_URI="ftp://ftp.freeradius.org/pub/radius/${P}.tar.gz"
HOMEPAGE="http://www.freeradius.org/"
KEYWORDS="x86 ~amd64 ~ppc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/libc
	>=sys-libs/db-3.2
	sys-libs/gdbm
	snmp? ( virtual/snmp )
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )
	pam? ( sys-libs/pam )
	ssl? ( dev-libs/openssl )
	ldap? ( net-nds/openldap )
	kerberos? ( virtual/krb5 )
	frxp? ( dev-lang/python
		dev-lang/perl )"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}

	# gcc-3.4 fix
	epatch ${FILESDIR}/${P}-gcc34.patch

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
	if use frnothreads; then
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
	# rlm_cram rlm_example rlm_perl
	# rlm_python rlm_sim_files rlm_smb rlm_sqlcounter 

	./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var \
		--mandir=/usr/share/man \
		--with-large-files --disable-ltdl-install --disable-static \
		${myconf} || die

	make || die
}

pkg_preinst() {
	enewgroup radiusd
	enewuser radiusd -1 /bin/false /var/log/radius radiusd
}

src_install() {
	dodir /etc
	dodir /var/log
	dodir /var/run
	pkg_preinst
	diropts -m0750 -o root -g radiusd
	dodir /etc/raddb
	diropts -m0750 -o radiusd -g radiusd
	dodir /var/log/radius
	dodir /var/log/radius/radacct
	dodir /var/run/radiusd
	diropts

	make R=${D} install || die
	dosed 's:^#user *= *nobody:user = radiusd:;s:^#group *= *nobody:group = radiusd:' \
	    /etc/raddb/radiusd.conf

	dodoc COPYRIGHT CREDITS INSTALL LICENSE README

	rm ${D}/usr/sbin/rc.radiusd

	exeinto /etc/init.d
	newexe ${FILESDIR}/0.9/radius.init radiusd

	dodir /etc/conf.d
	cp ${FILESDIR}/0.9/radius.conf ${D}/etc/conf.d/radiusd
}

