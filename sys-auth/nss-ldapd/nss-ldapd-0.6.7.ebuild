# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/nss-ldapd/nss-ldapd-0.6.7.ebuild,v 1.1 2008/12/04 22:17:14 cardoe Exp $

DESCRIPTION="NSS module for name lookups using LDAP"
HOMEPAGE="http://ch.tudelft.nl/~arthur/nss-ldapd/"
SRC_URI="http://ch.tudelft.nl/~arthur/nss-ldapd/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

DEPEND="net-nds/openldap
		!sys-auth/nss_ldap"
RDEPEND="${DEPEND}"

src_compile() {
	econf --enable-warnings --with-ldap-lib=openldap $(use_enable debug) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	# for socket and pid file
	mkdir "${D}"/var/run/nslcd

	# init script
	newinitd "${FILESDIR}"/nslcd.rc nslcd
}

pkg_postinst() {
	elog
	elog "For this to work you must configure /etc/nss-ldapd.conf"
	elog "This configuration is similar to pam_ldap's /etc/ldap.conf"
	elog
	elog "After configuring it, you MUST add `nslcd` to be started"
	elog "i.e. $ rc-update add nslcd default"
}
