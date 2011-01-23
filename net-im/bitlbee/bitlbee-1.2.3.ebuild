# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/bitlbee/bitlbee-1.2.3.ebuild,v 1.6 2011/01/23 14:55:15 armin76 Exp $

EAPI="1"
inherit eutils toolchain-funcs confutils

DESCRIPTION="irc to IM gateway that support multiple IM protocols"
HOMEPAGE="http://www.bitlbee.org/"
SRC_URI="http://get.bitlbee.org/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE="debug gnutls ipv6 +jabber msn nss +oscar ssl test +yahoo xinetd" # ldap - Bug 195758

COMMON_DEPEND=">=dev-libs/glib-2.4
	msn? ( gnutls? ( net-libs/gnutls )
		!gnutls? ( nss? ( dev-libs/nss ) )
		!gnutls? ( !nss? ( ssl? ( dev-libs/openssl ) ) )
		)
	jabber? ( gnutls? ( net-libs/gnutls )
		!gnutls? ( nss? ( dev-libs/nss ) )
		!gnutls? ( !nss? ( ssl? ( dev-libs/openssl ) ) )
		)"
	# ldap? ( net-nds/openldap )"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
	test? ( dev-libs/check )"

RDEPEND="${COMMON_DEPEND}
	virtual/logger
	xinetd? ( sys-apps/xinetd )"

pkg_setup() {
	elog "Note: Support for all IM protocols are controlled by use flags."
	elog "      Make sure you've enabled the flags you want."
	elog
	confutils_require_any jabber msn oscar yahoo

	# At the request of upstream, die if MSN Messenger support is enabled
	# but no SSL support has been enabled
	confutils_use_depend_any msn gnutls nss ssl

	if use jabber && ! use gnutls && ! use ssl ; then
		if use nss; then
			ewarn ""
			ewarn "You have enabled nss and jabber"
			ewarn "but nss doesn't work with jabber"
			ewarn "Enable ONE of the following use instead"
			ewarn "flags: gnutls or ssl"
			ewarn ""
			die "nss with jabber doesn't work"
		fi
		elog ""
		elog "You have enabled support for Jabber but do not have SSL"
		elog "support enabled.  This *will* prevent bitlbee from being"
		elog "able to connect to SSL enabled Jabber servers.  If you need to"
		elog "connect to Jabber over SSL, enable ONE of the following use"
		elog "flags: gnutls or ssl"
		elog ""
	fi

	enewgroup bitlbee
	enewuser bitlbee -1 -1 /var/lib/bitlbee bitlbee
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s@/usr/local/sbin/bitlbee@/usr/sbin/bitlbee@" \
		-e "s/nobody/bitlbee/" \
		-e "s/}/	disable         = yes\n}/" \
		doc/bitlbee.xinetd || die "sed failed in xinetd"

	sed -i \
		-e "s@mozilla-nss@nss@g" \
		configure || die "sed failed in configure"

	epatch "${FILESDIR}/${PN}-1.2.2-fix_tests_check_set.patch"
}

src_compile() {
	# ldap hard-disabled for now
	local myconf="--ldap=0"

	# setup protocol, ipv6 and debug
	for flag in debug ipv6 msn jabber oscar yahoo ; do
		if use ${flag} ; then
			myconf="${myconf} --${flag}=1"
		else
			myconf="${myconf} --${flag}=0"
		fi
	done

	# setup ssl use flags
	if use gnutls ; then
		myconf="${myconf} --ssl=gnutls"
		einfo "Use gnutls as SSL support"
	elif use ssl ; then
		myconf="${myconf} --ssl=openssl"
		einfo "Use openssl as SSL support"
	elif use nss ; then
		myconf="${myconf} --ssl=nss"
		einfo "Use nss as SSL support"
	else
		myconf="${myconf} --ssl=bogus"
		einfo "You will not have any encryption support enabled."
	fi

	# NOTE: bitlbee's configure script is not an autotool creation,
	# so that is why we don't use econf.
	./configure --prefix=/usr --datadir=/usr/share/bitlbee \
		--etcdir=/etc/bitlbee --strip=0 ${myconf} || die "econf failed"

	sed -i \
		-e "s/CFLAGS=.*$/CFLAGS=${CFLAGS}/" \
		Makefile.settings || die "sed failed"

	emake || die "make failed"

	# make bitlbeed forking server
	cd utils
	$(tc-getCC) ${CFLAGS} bitlbeed.c -o bitlbeed \
		|| die "bitlbeed failed to compile"
}

src_install() {
	make install DESTDIR="${D}" || die "install failed"
	make install-etc DESTDIR="${D}" || die "install failed"
	make install-doc DESTDIR="${D}" || die "install failed"
	keepdir /var/lib/bitlbee
	fperms 700 /var/lib/bitlbee
	fowners bitlbee:bitlbee /var/lib/bitlbee

	dodoc doc/{AUTHORS,CHANGES,CREDITS,FAQ,README}
	dodoc doc/user-guide/user-guide.txt
	dohtml -A xml doc/user-guide/*.xml
	dohtml -A xsl doc/user-guide/*.xsl
	dohtml doc/user-guide/*.html

	doman doc/bitlbee.8 doc/bitlbee.conf.5

	dobin utils/bitlbeed

	if use xinetd; then
		insinto /etc/xinetd.d
		newins doc/bitlbee.xinetd bitlbee
	fi

	newinitd "${FILESDIR}"/bitlbeed.initd bitlbeed || die
	newconfd "${FILESDIR}"/bitlbeed.confd2 bitlbeed || die

	keepdir /var/run/bitlbeed

	dodir /usr/share/bitlbee
	insinto /usr/share/bitlbee
	cd utils
	doins centericq2bitlbee.sh convert_gnomeicu.txt create_nicksfile.pl
	doins bitlbee-ctl.pl
}

pkg_postinst() {
	chown -R bitlbee:bitlbee "${ROOT}"/var/lib/bitlbee

	elog "The utils included in bitlbee (other than bitlbeed) are now"
	elog "located in /usr/share/bitlbee"
	elog
	elog "NOTE: The IRSSI script is no longer provided by BitlBee."
}
