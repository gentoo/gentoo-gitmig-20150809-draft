# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/postgrey/postgrey-1.21.ebuild,v 1.5 2005/08/23 13:13:34 ticho Exp $

inherit eutils

DESCRIPTION="Postgrey is a Postfix policy server implementing greylisting"
SRC_URI="http://isg.ee.ethz.ch/tools/${PN}/pub/${P}.tar.gz
		http://isg.ee.ethz.ch/tools/${PN}/pub/old/${P}.tar.gz"
HOMEPAGE="http://isg.ee.ethz.ch/tools/postgrey/"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
DEPEND=""
RDEPEND=">=dev-lang/perl-5.6.0
	dev-perl/net-server
	dev-perl/IO-Multiplex
	dev-perl/BerkeleyDB
	dev-perl/Net-DNS
	>=sys-libs/db-4.1
	>=mail-mta/postfix-2.1.0"

KEYWORDS="x86 amd64 ~alpha"

pkg_setup() {
	enewgroup postgrey
	enewuser postgrey -1 -1 /dev/null postgrey
}

src_install () {
	cd ${S}

	# postgrey data/DB in /var
	diropts -m0770 -o postgrey -g postgrey
	dodir /var/spool/postfix/postgrey
	keepdir /var/spool/postfix/postgrey
	fowners postgrey:postgrey /var/spool/postfix/postgrey
	fperms 0770 /var/spool/postfix/postgrey

	# postgrey binary
	dosbin postgrey
	dosbin contrib/postgreyreport

	# postgrey data in /etc/postfix
	insinto /etc/postfix
	insopts -o root -g postgrey -m 0640
	doins postgrey_whitelist_clients postgrey_whitelist_recipients

	# documentation
	dodoc Changes COPYING README

	# init.d + conf.d files
	newinitd ${FILESDIR}/postgrey.rc postgrey
	newconfd ${FILESDIR}/postgrey.conf postgrey
}

pkg_postinst() {
	echo
	einfo "To make use of greylisting, please update your postfix config:"
	einfo

	einfo "Add \"check_policy_service inet:127.0.0.1:10030\" to"
	einfo "smtpd_recipient restrictions setting in your /etc/postfix/main.cf"
	einfo "and restart postfix."

	einfo "Also remember to make the daemon start durig system boot:"
	einfo "  rc-update add postgrey default"
	echo
	ewarn "Read the documentation for more info (perldoc postgrey)."
	echo
	ebeep 5
	epause 5
}
