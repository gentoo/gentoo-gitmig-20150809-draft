# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/strongswan/strongswan-4.1.11.ebuild,v 1.3 2008/04/29 14:26:37 armin76 Exp $

inherit eutils linux-info

UGID="ipsec"

DESCRIPTION="Open Source implementation of IPsec for the Linux operating system."
HOMEPAGE="http://www.strongswan.org/"
SRC_URI="http://download.strongswan.org/${P}.tar.bz2"

LICENSE="GPL-2 RSA-MD2 RSA-MD5 RSA-PKCS11 DES"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE="cisco curl debug ldap nat smartcard static xml"

COMMON_DEPEND="!net-misc/openswan
	dev-libs/gmp"
DEPEND="${COMMON_DEPEND}
	virtual/linux-sources
	sys-kernel/linux-headers
	curl? ( net-misc/curl )
	ldap? ( net-nds/openldap )
	smartcard? ( dev-libs/opensc )
	xml? ( dev-libs/libxml2 )"
RDEPEND="${COMMON_DEPEND}
	virtual/logger
	sys-apps/iproute2"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/ipsec-install-${PV}.patch
}

pkg_setup() {
	linux-info_pkg_setup

	einfo "Linux kernel is version ${KV_FULL}"

	if kernel_is 2 6; then
		einfo "This ebuild will set ${P} to use 2.6 native IPsec (KAME)."
	else
		eerror "Sorry, no support for your kernel version ${KV_FULL}."
		die "Install an IPsec enabled 2.6 kernel."
	fi

	# change to an unprivileged user by default
	enewgroup ${UGID}
	enewuser ${UGID} -1 -1 -1 ${UGID}
}

src_compile() {
	local myconf=""

	# change to an unprivileged user by default
	myconf="${myconf} --with-uid=$(id -u ${UGID}) --with-gid=$(id -g ${UGID})"
	# strongswan enables both by default; switch to the user's wish
	if use static; then
		myconf="${myconf} --enable-static --disable-shared"
	else
		myconf="${myconf} --disable-static --enable-shared"
	fi

	econf \
		$(use_enable curl http) \
		$(use_enable ldap) \
		$(use_enable xml) \
		$(use_enable smartcard) \
		$(use_enable cisco cisco-quirks) \
		$(use_enable debug leak-detective) \
		$(use_enable nat nat-transport) \
		${myconf} \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed."

	doinitd "${FILESDIR}"/ipsec

	fowners ipsec:ipsec /etc/ipsec.conf
}

pkg_postinst() {
	echo
	ewarn "Starting with the strongswan-4 branch, the configuration files"
	ewarn "will be installed into the default directory \"/etc/\""
	ewarn "instead of the Gentoo-specific directory \"/etc/ipsec/\"."
	ewarn "Please adjust your configuration!"
	echo
	einfo "For your own security we install strongSwan without superuser"
	einfo "privileges.  If you use iptables, you might want to change that"
	einfo "setting.  See http://wiki.strongswan.org/wiki/nonRoot for more"
	einfo "information."
	echo
	einfo "The up-to-date configuration manual is available online at"
	einfo "http://www.strongswan.org/docs/readme.htm"
	echo
}
