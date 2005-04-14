# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/freeradius/freeradius-1.0.2-r2.ebuild,v 1.4 2005/04/14 20:48:21 mrness Exp $

inherit eutils

DESCRIPTION="highly configurable free RADIUS server"
SRC_URI="ftp://ftp.freeradius.org/pub/radius/${P}.tar.gz"
HOMEPAGE="http://www.freeradius.org/"

KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
LICENSE="GPL-2"
SLOT="0"
IUSE="frascend frnothreads frxp kerberos ldap mysql pam postgres snmp ssl"

DEPEND="!net-dialup/cistronradius
	!net-dialup/gnuradius
	virtual/libc
	>=sys-libs/db-3.2
	sys-libs/gdbm
	snmp? ( net-analyzer/net-snmp )
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

	epatch ${FILESDIR}/${P}-whole-archive-gentoo.patch

	export WANT_AUTOCONF=2.1
	autoconf
}

src_compile() {
	local myconf=""

	if ! useq snmp; then
		myconf="--without-snmp"
	fi
	if useq frascend; then
		myconf="${myconf} --with-ascend-binary"
	fi
	if useq frnothreads; then
		myconf="${myconf} --without-threads"
	fi
	if useq frxp; then
		myconf="${myconf} --with-experimental-modules"
	fi
	#fix bug #77613
	if has_version app-crypt/heimdal; then
		myconf="${myconf} --enable-heimdal-krb5"
	fi

	# kill modules we don't use
	if ! useq ssl; then
		einfo "removing rlm_eap_tls and rlm_x99_token (no use ssl)"
		rm -rf src/modules/rlm_eap/types/rlm_eap_tls src/modules/rlm_x99_token
	fi
	if ! useq ldap; then
		einfo "removing rlm_ldap (no use ldap)"
		rm -rf src/modules/rlm_ldap
	fi
	if ! useq kerberos; then
		einfo "removing rlm_krb5 (no use kerberos)"
		rm -rf src/modules/rlm_krb5
	fi
	if ! useq pam; then
		einfo "removing rlm_pam (no use pam)"
		rm -rf src/modules/rlm_pam
	fi

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

	[ -z "${PR}" ] || mv ${D}/usr/share/doc/${P} ${D}/usr/share/doc/${PF}
	gzip -f -9 ${D}/usr/share/doc/${PF}/{rfc/*.txt,*}
	dodoc COPYRIGHT CREDITS INSTALL LICENSE
	#Copy SQL schemas to doc dir
	docinto sql.schemas
	dodoc src/modules/rlm_sql/drivers/rlm_sql_*/*.sql

	rm ${D}/usr/sbin/rc.radiusd

	exeinto /etc/init.d
	newexe ${FILESDIR}/radius.init radiusd

	insinto /etc/conf.d
	newins ${FILESDIR}/radius.conf radiusd
}

