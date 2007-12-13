# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/bitlbee/bitlbee-1.1-r1.ebuild,v 1.1 2007/12/13 20:40:21 cedk Exp $

EAPI="1"
inherit eutils toolchain-funcs confutils

MY_P="${P}dev"

DESCRIPTION="irc to IM gateway that support multiple IM protocols"
HOMEPAGE="http://www.bitlbee.org/"
SRC_URI="http://get.bitlbee.org/src/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="debug gnutls ipv6 +jabber msn nss +oscar ssl +yahoo xinetd" # ldap - Bug 195758

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
	dev-util/pkgconfig"

RDEPEND="${COMMON_DEPEND}
	virtual/logger
	xinetd? ( sys-apps/xinetd )"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	elog "Note: Support for all IM protocols are controlled by use flags."
	elog "      Make sure you've enabled the flags you want."
	elog
	confutils_require_any jabber msn oscar yahoo

	# At the request of upstream, die if MSN Messenger support is enabled
	# but no SSL support has been enabled
	confutils_use_depend_any msn gnutls nss ssl

	# Warn but not die if jabber is enabled but SSL is not
	if use jabber && ! use gnutls && ! use nss && ! use ssl ; then
		ewarn ""
		ewarn "You have enabled support for Jabber but do not have SSL"
		ewarn "support enabled.  This *will* prevent bitlbee from being"
		ewarn "able to connect to SSL enabled Jabber servers.  If you need to"
		ewarn "connect to Jabber over SSL, enable ONE of the following use"
		ewarn "flags: gnutls, nss or ssl"
		ewarn ""
	fi

	enewgroup bitlbee
	enewuser bitlbee -1 -1 /var/lib/bitlbee bitlbee
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/oscar-sms.patch"

	sed -i \
		-e "s@/usr/local/sbin/bitlbee@/usr/sbin/bitlbee@" \
		-e "s/nobody/bitlbee/" \
		-e "s/}/	disable         = yes\n}/" \
		doc/bitlbee.xinetd || die "sed failed in xinetd"
	
	sed -i \
		-e "s@mozilla-nss@nss@g" \
		configure || die "sed failed in configure"
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
	elif use nss ; then
		myconf="${myconf} --ssl=nss"
	elif use ssl ; then
		myconf="${myconf} --ssl=openssl"
	elif use jabber && ! use gnutls && ! use nss && ! use ssl ; then
		myconf="${myconf} --ssl=bogus"
	else
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
	doins bitlbee-ctl.pl
}

pkg_postinst() {
	chown -R bitlbee:bitlbee ${ROOT}/var/lib/bitlbee

	elog "The utils included in bitlbee (other than bitlbeed) are now"
	elog "located in /usr/share/bitlbee"
	elog
	elog "NOTE: The IRSSI script is no longer provided by BitlBee."
}
