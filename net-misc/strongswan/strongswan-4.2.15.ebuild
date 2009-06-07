# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/strongswan/strongswan-4.2.15.ebuild,v 1.1 2009/06/07 15:04:06 rbu Exp $

EAPI=2
inherit eutils linux-info autotools

UGID="ipsec"

DESCRIPTION="Open Source implementation of IPsec for the Linux operating system."
HOMEPAGE="http://www.strongswan.org/"
SRC_URI="http://download.strongswan.org/${P}.tar.bz2"

LICENSE="GPL-2 RSA-MD2 RSA-MD5 RSA-PKCS11 DES"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86 ~amd64"
IUSE="caps cisco curl debug ldap nat smartcard static xml"

COMMON_DEPEND="!net-misc/openswan
	dev-libs/gmp
	caps? ( sys-libs/libcap )
	curl? ( net-misc/curl )
	ldap? ( net-nds/openldap )
	smartcard? ( dev-libs/opensc )
	xml? ( dev-libs/libxml2 )"
DEPEND="${COMMON_DEPEND}
	virtual/linux-sources
	sys-kernel/linux-headers"
RDEPEND="${COMMON_DEPEND}
	virtual/logger
	sys-apps/iproute2"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-4.2.7-install.patch
	eautoreconf
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

src_configure() {
	local myconf=""

	# change to an unprivileged user by default
	myconf="${myconf} --with-user=${UGID} --with-group=${UGID}"
	# strongswan enables both by default; switch to the user's wish
	if use static; then
		myconf="${myconf} --enable-static --disable-shared"
	else
		myconf="${myconf} --disable-static --enable-shared"
	fi

	# TODO: Review new configure options such as networkmanager
	econf \
		$(use_with caps capabilities libcap) \
		$(use_enable curl) \
		$(use_enable ldap) \
		$(use_enable xml smp) \
		$(use_enable smartcard) \
		$(use_enable cisco cisco-quirks) \
		$(use_enable debug leak-detective) \
		$(use_enable nat nat-transport) \
		${myconf} \
		|| die "econf failed"
}

src_install() {
	einstall || die "einstall failed."

	doinitd "${FILESDIR}"/ipsec

	fowners ipsec:ipsec /etc/ipsec.conf
}

pkg_postinst() {
	echo
	einfo "For your own security we install strongSwan without superuser"
	einfo "privileges.  If you use iptables, you might want to change that"
	einfo "setting.  See http://wiki.strongswan.org/wiki/nonRoot for more"
	einfo "information."
	# TODO: Should we recommend this sudoers line to users?
	# %ipsec ALL = NOPASSWD: /sbin/iptables
	echo
	einfo "The up-to-date configuration manual is available online at"
	einfo "http://www.strongswan.org/docs/readme42.htm"
	echo
}
