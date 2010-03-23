# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/strongswan/strongswan-4.3.6-r1.ebuild,v 1.3 2010/03/23 01:38:58 yngwin Exp $

EAPI=2

inherit eutils linux-info

DESCRIPTION="Open Source IPsec based VPN solution with a strong focus on security. Fully supports IKEv1/IKEv2, MOBIKE and the Linux 2.6 IPsec stack."
HOMEPAGE="http://www.strongswan.org/"
SRC_URI="http://download.strongswan.org/${P}.tar.bz2"

LICENSE="GPL-2 RSA-MD5 RSA-PKCS11 DES"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86 ~amd64"
IUSE="+caps cisco curl debug gcrypt ldap +ikev1 +ikev2 mysql nat +non-root +openssl smartcard sqlite"

COMMON_DEPEND="!net-misc/openswan
	dev-libs/gmp
	gcrypt? ( dev-libs/libgcrypt )
	caps? ( sys-libs/libcap )
	curl? ( net-misc/curl )
	ldap? ( net-nds/openldap )
	smartcard? ( dev-libs/opensc )
	openssl? ( >=dev-libs/openssl-0.9.8 )
	mysql? ( virtual/mysql )
	sqlite? ( >=dev-db/sqlite-3.3.1 )"
DEPEND="${COMMON_DEPEND}
	virtual/linux-sources
	sys-kernel/linux-headers"
RDEPEND="${COMMON_DEPEND}
	virtual/logger
	sys-apps/iproute2"

UGID="ipsec"

pkg_setup() {
	linux-info_pkg_setup
	elog "Linux kernel version: ${KV_FULL}"

	if kernel_is 2 6; then
		elog "Using native Linux 2.6 IPsec stack."
	else
		eerror
		eerror "This ebuild currently only supports ${PN} with the"
		eerror "native Linux 2.6 IPsec stack."
		eerror
		die "Please install a recent 2.6 kernel."
	fi

	if use non-root; then
		enewgroup ${UGID}
		enewuser ${UGID} -1 -1 -1 ${UGID}
	fi
}

src_configure() {
	local myconf=""

	if use non-root; then
		myconf="${myconf} --with-user=${UGID} --with-group=${UGID}"
	fi

	# If a user has already enabled db support, those plugins will
	# most likely be desired as well. Besides they don't impose new
	# dependencies and come at no cost (except for space).
	if use mysql || use sqlite; then
		myconf="${myconf} --enable-attr-sql --enable-sql"
	fi

	# strongSwan builds and installs static libs by default which are
	# useless to the user (and to strongSwan for that matter) because no
	# header files or alike get installed... so disabling them is safe.
	econf \
		--disable-static \
		$(use_with caps capabilities libcap) \
		$(use_enable curl) \
		$(use_enable ldap) \
		$(use_enable smartcard) \
		$(use_enable cisco cisco-quirks) \
		$(use_enable debug leak-detective) \
		$(use_enable nat nat-transport) \
		$(use_enable openssl) \
		$(use_enable gcrypt) \
		$(use_enable mysql) \
		$(use_enable sqlite) \
		$(use_enable ikev1 pluto) \
		$(use_enable ikev2 charon) \
		${myconf} \
		|| die "econf failed"
}

src_install() {
	einstall || die "einstall failed"

	doinitd "${FILESDIR}"/ipsec

	local dir_ugid
	if use non-root; then
		fowners ${UGID}:${UGID} \
			/etc/ipsec.conf \
			/etc/ipsec.secrets \
			/etc/strongswan.conf

		dir_ugid="${UGID}"
	else
		dir_ugid="root"
	fi

	diropts -m 0750 -o ${dir_ugid} -g ${dir_ugid}
	dodir /etc/ipsec.d \
		/etc/ipsec.d/aacerts \
		/etc/ipsec.d/acerts \
		/etc/ipsec.d/cacerts \
		/etc/ipsec.d/certs \
		/etc/ipsec.d/crls \
		/etc/ipsec.d/ocspcerts \
		/etc/ipsec.d/private \
		/etc/ipsec.d/reqs

	dodoc CREDITS NEWS README TODO

	# shared libs are used only internally and there are no static libs,
	# so it's safe to get rid of the .la files
	find "${D}" -name '*.la' -delete || die "Failed to remove .la files."
}

pkg_preinst() {
	has_version "<net-misc/strongswan-4.3.6-r1"
	upgrade_from_leq_4_3_6=$?
	if [[ $upgrade_from_leq_4_3_6 == 0 ]]; then
		built_with_use net-misc/strongswan caps
		previous_4_3_6_with_caps=$?
	fi
}

pkg_postinst() {
	if ! use openssl ; then
		elog
		elog "${PN} has been compiled without OpenSSL support."
		elog "Please note that (among other things), support for"
		elog "ECDSA authentification and several ECP Diffie-Hellman groups"
		elog "is missing."
		elog "If you require any of the above functionality, please re-emerge"
		elog "with the \"openssl\" USE flag enabled."
		elog
	fi
	if [[ $upgrade_from_leq_4_3_6 == 0 ]]; then
		chmod 0750 "${ROOT}"/etc/ipsec.d \
			"${ROOT}"/etc/ipsec.d/aacerts \
			"${ROOT}"/etc/ipsec.d/acerts \
			"${ROOT}"/etc/ipsec.d/cacerts \
			"${ROOT}"/etc/ipsec.d/certs \
			"${ROOT}"/etc/ipsec.d/crls \
			"${ROOT}"/etc/ipsec.d/ocspcerts \
			"${ROOT}"/etc/ipsec.d/private \
			"${ROOT}"/etc/ipsec.d/reqs

		ewarn
		ewarn "The default permissions for /etc/ipsec.d/* have been tightened for"
		ewarn "security reasons. Your system installed directories have been"
		ewarn "updated accordingly. Please check if necessary."
		ewarn

		if [[ $previous_4_3_6_with_caps == 0 ]]; then
			if ! use non-root; then
				ewarn
				ewarn "IMPORTANT: You previously had ${PN} installed without root"
				ewarn "priviledges because it was implied by the 'caps' USE flag."
				ewarn "This has been changed. If you want ${PN} with user priviledges,"
				ewarn "you have to re-emerge it with the 'non-root' USE flag enabled."
				ewarn
			fi
		fi
	fi
	if ! use caps && ! use non-root; then
		ewarn
		ewarn "You have decided to run ${PN} with root priviledges and built it"
		ewarn "without support for POSIX capability dropping. It is generally"
		ewarn "strongly suggested that you reconsider- especially if you intend"
		ewarn "to run ${PN} as server with a public ip address."
		ewarn
		ewarn "You should re-emerge ${PN} with at least the 'caps' USE flag enabled."
		ewarn
	fi
	if use non-root; then
		elog
		elog "${PN} has been installed without superuser priviledges (USE=non-root)."
		elog "This imposes several limitations mainly to the IKEv1 daemon 'pluto'"
		elog "but also a few to the IKEv2 daemon 'charon'."
		elog
		elog "Please carefully read: http://wiki.strongswan.org/wiki/nonRoot"
		elog
		elog "pluto uses a helper script by default to insert/remove routing and"
		elog "policy rules upon connection start/stop which requires superuser"
		elog "priviledges. charon in contrast does this internally and can do so"
		elog "even with reduced (user) priviledges."
		elog
		elog "Thus if you require IKEv1 (pluto) or need to specify a custom updown"
		elog "script to pluto or charon which requires superuser priviledges, you"
		elog "can work around this limitation by using sudo to grant the"
		elog "user \"ipsec\" the appropriate rights."
		elog "For example (the default case):"
		elog "/etc/sudoers:"
		elog "  Defaults:ipsec always_set_home,!env_reset"
		elog "  ipsec ALL=(ALL) NOPASSWD: /usr/sbin/ipsec"
		elog "Under the specific connection block in /etc/ipsec.conf:"
		elog "  leftupdown=\"sudo ipsec _updown\""
		elog
	fi
	elog
	elog "The up-to-date manual is available online at:"
	elog "  http://wiki.strongswan.org/"
	elog
}
