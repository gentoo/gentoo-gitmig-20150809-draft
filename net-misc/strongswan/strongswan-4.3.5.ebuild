# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/strongswan/strongswan-4.3.5.ebuild,v 1.1 2009/11/02 13:23:04 wschlich Exp $

EAPI=2
inherit eutils linux-info

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
	dev-libs/libgcrypt
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

#src_prepare() {
#	epatch "${FILESDIR}"/${PN}-4.3.3-install.patch
#	eautoreconf
#}

pkg_setup() {
	linux-info_pkg_setup

	elog "Linux kernel is version ${KV_FULL}"

	if kernel_is 2 6; then
		elog "This ebuild will set ${P} to use 2.6 native IPsec (KAME)."
	else
		eerror "Sorry, no support for your kernel version ${KV_FULL}."
		die "Install an IPsec enabled 2.6 kernel."
	fi

	if use caps; then
		# change to an unprivileged user if libcaps support is requested
		enewgroup ${UGID}
		enewuser ${UGID} -1 -1 -1 ${UGID}
	fi
}

src_configure() {
	local myconf=""

	if use caps; then
		# change to an unprivileged user if libcaps support is requested
		myconf="${myconf} --with-user=${UGID} --with-group=${UGID}"
	fi

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

	if use caps; then
		fowners ipsec:ipsec /etc/ipsec.conf
	fi
}

pkg_postinst() {
	if use caps; then
		echo
		elog "strongSwan has been installed without superuser privileges as"
		elog "requested (USE=caps). There are certain restrictions and"
		elog "issues regarding non-root operation, so please have a look at:"
		elog "  http://wiki.strongswan.org/wiki/nonRoot"
		echo
		elog "Please be aware that with dropped privileges most leftupdown and"
		elog "rightupdown scripts will no longer run if they require root privileges."
		elog "You might want to use sudo to allow the user \"ipsec\" to run"
		elog "the ipsec helper script (/usr/sbin/ipsec) as root."
		elog "Example for /etc/sudoers:"
		elog "  Defaults:ipsec always_set_home,!env_reset"
		elog "  ipsec ALL=(ALL) NOPASSWD: /usr/sbin/ipsec"
		elog "Example for a connection block in /etc/ipsec.conf:"
		elog "  leftupdown=\"sudo ipsec _updown\""
		echo
#		elog "And please do not forget to add CAP_NET_ADMIN capabilities to"
#		elog "your charon and pluto binaries each time you emerge this ebuild."
#		echo
#		elog "setcap -v cap_net_admin=ep /usr/libexec/ipsec/pluto"
#		elog "setcap -v cap_net_admin=ep /usr/libexec/ipsec/charon"
#		echo
#		elog "For more information reagrding POSIX capabilities support please"
#		elog "have a look at http://www.friedhoff.org/posixfilecaps.html"
#		echo
	fi
	elog "The up-to-date manual is available online at:"
	elog "  http://wiki.strongswan.org/"
	echo
}
