# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/postgrey/postgrey-1.27.ebuild,v 1.3 2006/12/24 10:48:02 ticho Exp $

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
	>=sys-libs/db-4.1"

KEYWORDS="~alpha ~amd64 ~ppc64 ~x86"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /dev/null ${PN}
}

src_install () {
	cd ${S}

	# postgrey data/DB in /var
	diropts -m0770 -o ${PN} -g ${PN}
	dodir /var/spool/postfix/${PN}
	keepdir /var/spool/postfix/${PN}
	fowners postgrey:postgrey /var/spool/postfix/${PN}
	fperms 0770 /var/spool/postfix/${PN}

	# postgrey binary
	dosbin ${PN}
	dosbin contrib/postgreyreport

	# postgrey data in /etc/postfix
	insinto /etc/postfix
	insopts -o root -g ${PN} -m 0640
	doins postgrey_whitelist_clients postgrey_whitelist_recipients

	# documentation
	dodoc Changes README

	# init.d + conf.d files
	newinitd ${FILESDIR}/${PN}.rc.new ${PN}
	newconfd ${FILESDIR}/${PN}.conf.new ${PN}
}

pkg_postinst() {
	echo
	einfo "To make use of greylisting, please update your postfix config:"
	einfo

	einfo "In order to start using postgrey, edit /etc/conf.d/postgrey, add following lines"
	einfo "to smtpd_recipient restrictions setting in your /etc/postfix/main.cf:"
	einfo "\t\"check_policy_service inet:127.0.0.1:10030\", if you're using TCP socket"
	einfo "\t\"check_policy_service unix:private/postgrey\", if you're using UNIX socket"
	einfo "Then, start postgrey and restart postfix."

	einfo "Also remember to make the daemon start durig system boot:"
	einfo "  rc-update add postgrey default"
	echo
	ewarn "Read postgrey documentation for more info (perldoc postgrey)."
	echo
	epause 5
}
