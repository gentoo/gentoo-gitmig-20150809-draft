# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/policyd-weight/policyd-weight-0.1.14.5.ebuild,v 1.4 2007/08/13 12:12:03 angelos Exp $

inherit eutils

DESCRIPTION="Weighted Policy daemon for Postfix"
HOMEPAGE="http://www.policyd-weight.org/"
SRC_URI="http://www.policyd-weight.org/old/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="perl-core/Sys-Syslog
	dev-perl/Net-DNS
	>=mail-mta/postfix-2.1"

pkg_setup() {
	enewgroup 'polw'
	enewuser 'polw' -1 -1 -1 'polw'
}

src_install() {
	exeinto /usr/lib/postfix
	doexe policyd-weight
	fowners root:wheel /usr/lib/postfix/policyd-weight

	doman man/man5/*.5 man/man8/*.8
	dodoc *.txt

	insinto /etc
	newins policyd-weight.conf.sample policyd-weight.conf

	newinitd "${FILESDIR}/${PN}.init.d" "${PN}"
}

pkg_postinst() {
	elog "To use policyd-weight with postfix, update your /etc/postfix/main.cf file by adding"
	elog "  check_policy_service inet:127.0.0.1:12525"
	elog "to your smtpd_recipient_restrictions."
	elog
	elog "Also remember to start policyd-weight at boot:"
	elog "  rc-update add policyd-weight default"
	echo
	ewarn "Please note:"
	ewarn "If you are getting legitimate e-mails from verizon.net, it is advised to"
	ewarn "whitelist the domain in postfix. Because of the way they send their"
	ewarn "emails, they are often listed in RBLs."
	echo
}
