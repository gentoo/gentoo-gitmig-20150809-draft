# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/nss-ldapd/nss-ldapd-0.6.7-r1.ebuild,v 1.4 2012/07/24 07:18:53 prometheanfire Exp $

inherit multilib

DESCRIPTION="NSS module for name lookups using LDAP"
HOMEPAGE="http://ch.tudelft.nl/~arthur/nss-ldapd/"
SRC_URI="http://ch.tudelft.nl/~arthur/nss-ldapd/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug kerberos sasl"

DEPEND="net-nds/openldap
		sasl? ( dev-libs/cyrus-sasl )
		kerberos? ( virtual/krb5 )
		!sys-auth/nss_ldap"
RDEPEND="${DEPEND}"

src_compile() {
	# nss libraries always go in /lib on Gentoo
	econf --enable-warnings --with-ldap-lib=openldap $(use_enable debug) \
		--libdir=/$(get_libdir) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc NEWS ChangeLog AUTHORS README

	# for socket and pid file
	keepdir /var/run/nslcd

	# init script
	newinitd "${FILESDIR}"/nslcd.rc nslcd

	# make an example copy
	insinto /usr/share/nss-ldapd
	doins nss-ldapd.conf

	fperms o-r /etc/nss-ldapd.conf
}

pkg_postinst() {
	elog
	elog "For this to work you must configure /etc/nss-ldapd.conf"
	elog "This configuration is similar to pam_ldap's /etc/ldap.conf"
	elog
	elog "In order to use nss-ldapd, nslcd needs to be running. You can"
	elog "start it like this:"
	elog "  # /etc/init.d/nslcd start"
	elog
	elog "You can add it to the default runlevel like so:"
	elog " # rc-update add nslcd default"
}
