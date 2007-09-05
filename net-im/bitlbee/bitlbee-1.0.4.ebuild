# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/bitlbee/bitlbee-1.0.4.ebuild,v 1.1 2007/09/05 21:35:23 cedk Exp $

inherit eutils toolchain-funcs

DESCRIPTION="irc to IM gateway that support multiple IM protocols"
HOMEPAGE="http://www.bitlbee.org/"
SRC_URI="http://get.bitlbee.org/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="debug jabber msn oscar yahoo gnutls ssl nss xinetd ipv6"

DEPEND=">=dev-libs/glib-2.0
	msn? ( gnutls? ( net-libs/gnutls )
		ssl? ( dev-libs/openssl )
		nss? ( dev-libs/nss ) )
	jabber? ( gnutls? ( net-libs/gnutls )
			ssl? ( dev-libs/openssl )
			nss? ( dev-libs/nss ) )"

no_flags_die() {
	eerror ""
	eerror "Please choose a protocol or protocols to use with"
	eerror "bitlbee by enabling the useflag for the protocol"
	eerror "desired."
	eerror ""
	eerror " Valid useflags are;"
	eerror " jabber, msn, oscar and yahoo"
	die "No IM protocols selected!"
}

pkg_setup() {
	elog "Note: Support for all IM protocols are controlled by use flags."
	elog "      Make sure you've enabled the flags you want."
	elog ""

	# Warn but not die if jabber is enabled but SSL is not
	if ( use jabber && ( use !ssl && use !gnutls && use !nss ) ); then
		ewarn ""
		ewarn "You have enabled support for Jabber but do not have SSL"
		ewarn "support enabled.  This *will* prevent bitlbee from being"
		ewarn "able to connect to SSL enabled Jabber servers.  If you need to"
		ewarn "connect to Jabber over SSL, enable one of the following use"
		ewarn "flags: gnutls, nss ssl"
		ewarn ""
	fi

	# At the request of upstream, die if MSN Messenger support is enabled
	# but no SSL support has been enabled
	if  ( use msn && ( use !ssl && use !gnutls && use !nss ) ); then
		eerror ""
		eerror "In order to enable support for the MSN Messenger protocol,"
		eerror "SSL support needs to be enabled.  Please enable the ssl,"
		eerror "gnutls or nss use flags to provide SSL support".
		die "MSN support enabled without any SSL support enabled."
	fi

	use jabber || use msn || use oscar || use yahoo || no_flags_die

	enewgroup bitlbee
	enewuser bitlbee -1 -1 /var/lib/bitlbee bitlbee
}

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"

	sed -i \
		-e "s@/usr/local/sbin/bitlbee@/usr/sbin/bitlbee@" \
		-e "s/nobody/bitlbee/" \
		-e "s/}/	disable         = yes\n}/" \
		doc/bitlbee.xinetd || die "sed failed"
}

src_compile() {
	# setup protocol, ipv6 and debug
	local myconf
	use debug && myconf="${myconf} --debug=1"
	use ipv6 || myconf="${myconf} --ipv6=0"
	use msn || myconf="${myconf} --msn=0 "
	use jabber || myconf="${myconf} --jabber=0"
	use oscar || myconf="${myconf} --oscar=0"
	use yahoo || myconf="${myconf} --yahoo=0"

	# setup ssl use flags
	use ssl && use gnutls && myconf="${myconf} --ssl=gnutls"
	use ssl && use nss && myconf="${myconf} --ssl=nss"
	use ssl && use !gnutls && use !nss && \
		myconf="${myconf} --ssl=openssl"

	if ( ( use jabber && ( use gnutls || use ssl || use nss ) ) \
		|| use msn ) &&  use !gnutls && use !ssl && use !nss; then
		myconf="${myconf} --ssl=bogus"
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
	make install DESTDIR=${D} || die "install failed"
	make install-etc DESTDIR=${D} || die "install failed"
	make install-doc DESTDIR=${D} || die "install failed"
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
}

pkg_postinst() {
	chown -R bitlbee:bitlbee ${ROOT}/var/lib/bitlbee

	elog "The utils included in bitlbee (other than bitlbeed) are now"
	elog "located in /usr/share/bitlbee"
	elog
	elog "NOTE: The IRSSI script is no longer provided by BitlBee."
}
