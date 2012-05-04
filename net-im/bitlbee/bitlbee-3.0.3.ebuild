# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/bitlbee/bitlbee-3.0.3.ebuild,v 1.7 2012/05/04 06:22:12 jdhore Exp $

EAPI="4"
inherit eutils multilib

DESCRIPTION="irc to IM gateway that support multiple IM protocols"
HOMEPAGE="http://www.bitlbee.org/"
SRC_URI="http://get.bitlbee.org/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE="debug gnutls ipv6 +jabber libevent msn nss +oscar otr +plugins purple ssl test twitter +yahoo xinetd" # ldap - Bug 195758

COMMON_DEPEND="purple? ( net-im/pidgin )
	libevent? ( dev-libs/libevent )
	!libevent? ( >=dev-libs/glib-2.4 )
	otr? ( net-libs/libotr )
	gnutls? ( net-libs/gnutls )
	!gnutls? (
		nss? ( dev-libs/nss )
		!nss? ( ssl? ( dev-libs/openssl ) )
	)"
	# ldap? ( net-nds/openldap )"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	test? ( dev-libs/check )"

RDEPEND="${COMMON_DEPEND}
	virtual/logger
	xinetd? ( sys-apps/xinetd )"

REQUIRED_USE="^^ ( purple || ( jabber msn oscar yahoo ) )
	msn? ( || ( gnutls nss ssl ) )
	jabber? ( !nss )"

pkg_setup() {
	if use jabber && ! use gnutls && ! use ssl ; then
		einfo
		elog "You have enabled support for Jabber but do not have SSL"
		elog "support enabled.  This *will* prevent bitlbee from being"
		elog "able to connect to SSL enabled Jabber servers.  If you need to"
		elog "connect to Jabber over SSL, enable ONE of the following use"
		elog "flags: gnutls or ssl"
		einfo
	fi

	enewgroup bitlbee
	enewuser bitlbee -1 -1 /var/lib/bitlbee bitlbee
}

src_prepare() {
	sed -i \
		-e "s@/usr/local/sbin/bitlbee@/usr/sbin/bitlbee@" \
		-e "s/nobody/bitlbee/" \
		-e "s/}/	disable         = yes\n}/" \
		doc/bitlbee.xinetd || die "sed failed in xinetd"

	sed -i \
		-e "s@mozilla-nss@nss@g" \
		configure || die "sed failed in configure"

	epatch "${FILESDIR}"/${PN}-3.0-configure.patch
}

src_configure() {
	# ldap hard-disabled for now
	local myconf="--ldap=0"

	# setup plugins, protocol, ipv6 and debug
	for flag in debug ipv6 msn jabber oscar plugins purple twitter yahoo ; do
		if use ${flag} ; then
			myconf="${myconf} --${flag}=1"
		else
			myconf="${myconf} --${flag}=0"
		fi
	done

	# set otr
	if use otr && use plugins ; then
		myconf="${myconf} --otr=plugin"
	else
		if use otr ; then
			ewarn "OTR support has been disabled automatically because it"
			ewarn "requires the plugins USE flag."
		fi
		myconf="${myconf} --otr=0"
	fi

	# setup ssl use flags
	if use gnutls ; then
		myconf="${myconf} --ssl=gnutls"
		einfo "Using gnutls for SSL support"
	elif use ssl ; then
		myconf="${myconf} --ssl=openssl"
		einfo "Using openssl for SSL support"
	elif use nss ; then
		myconf="${myconf} --ssl=nss"
		einfo "Using nss for SSL support"
	else
		myconf="${myconf} --ssl=bogus"
		einfo "You will not have any encryption support enabled."
	fi

	# set event handler
	if use libevent ; then
		myconf="${myconf} --events=libevent"
	else
		myconf="${myconf} --events=glib"
	fi

	# NOTE: bitlbee's configure script is not an autotool creation,
	# so that is why we don't use econf.
	./configure --prefix=/usr --datadir=/usr/share/bitlbee \
		--etcdir=/etc/bitlbee --plugindir=/usr/$(get_libdir)/bitlbee \
		--strip=0 ${myconf} || die "econf failed"

	sed -i \
		-e "/^EFLAGS/s:=:&${LDFLAGS} :" \
		Makefile.settings || die "sed failed"
}

src_install() {
	emake install install-etc install-doc install-dev DESTDIR="${D}"

	keepdir /var/lib/bitlbee
	fperms 700 /var/lib/bitlbee
	fowners bitlbee:bitlbee /var/lib/bitlbee

	dodoc doc/{AUTHORS,CHANGES,CREDITS,FAQ,README}
	dodoc doc/user-guide/user-guide.txt
	dohtml doc/user-guide/*.html

	doman doc/bitlbee.8 doc/bitlbee.conf.5

	if use xinetd ; then
		insinto /etc/xinetd.d
		newins doc/bitlbee.xinetd bitlbee
	fi

	newinitd "${FILESDIR}"/bitlbee.initd bitlbee
	newconfd "${FILESDIR}"/bitlbee.confd bitlbee

	keepdir /var/run/bitlbee
	fowners bitlbee:bitlbee /var/run/bitlbee

	exeinto /usr/share/bitlbee
	cd utils
	doexe convert_purple.py bitlbee-ctl.pl
}

pkg_postinst() {
	chown -R bitlbee:bitlbee "${ROOT}"/var/lib/bitlbee
	chown -R bitlbee:bitlbee "${ROOT}"/var/run/bitlbee

	einfo
	elog "The utils included in bitlbee are now located in /usr/share/bitlbee"
	elog
	elog "NOTE: The IRSSI script is no longer provided by BitlBee."
	elog
	elog "The bitlbeed init script has been replaced by bitlbee."
	elog "You must update your configuration."
	einfo
}
