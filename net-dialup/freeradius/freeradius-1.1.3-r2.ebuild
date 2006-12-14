# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/freeradius/freeradius-1.1.3-r2.ebuild,v 1.1 2006/12/14 17:56:06 mrness Exp $

inherit eutils flag-o-matic multilib

DESCRIPTION="highly configurable free RADIUS server"
SRC_URI="ftp://ftp.freeradius.org/pub/radius/${P}.tar.gz"
HOMEPAGE="http://www.freeradius.org/"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="debug edirectory frascend frnothreads frxp kerberos ldap mysql pam postgres snmp ssl udpfromto"

DEPEND="!net-dialup/cistronradius
	!net-dialup/gnuradius
	>=sys-libs/db-3.2
	sys-libs/gdbm
	dev-lang/perl
	snmp? ( net-analyzer/net-snmp )
	mysql? ( virtual/mysql )
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
}

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-versionless-la-files.patch"
	epatch "${FILESDIR}/${P}-nostrip.patch"
	epatch "${FILESDIR}/${P}-ssl.patch"
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
