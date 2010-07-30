# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/postgrey/postgrey-1.32.ebuild,v 1.9 2010/07/30 16:33:12 dertobi123 Exp $

inherit eutils

DESCRIPTION="Postgrey is a Postfix policy server implementing greylisting"
SRC_URI="http://postgrey.schweikert.ch/pub/${P}.tar.gz
			http://postgrey.schweikert.ch/pub/old/${P}.tar.gz
			targrey? ( http://k2net.hakuba.jp/pub/targrey-0.31-${P}.patch )"
HOMEPAGE="http://postgrey.schweikert.ch/"
LICENSE="GPL-2"
SLOT="0"
IUSE="targrey"
DEPEND=""
RDEPEND=">=dev-lang/perl-5.6.0
	dev-perl/net-server
	dev-perl/IO-Multiplex
	dev-perl/BerkeleyDB
	dev-perl/Net-DNS
	dev-perl/Parse-Syslog
	dev-perl/Net-RBLClient
	>=sys-libs/db-4.1"

KEYWORDS="alpha amd64 hppa ~ppc ppc64 sparc x86"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /dev/null ${PN}
}

src_compile() {
	if use targrey ; then
		epatch "${DISTDIR}/targrey-0.31-${P}.patch"
	fi
}

src_install() {
	# postgrey data/DB in /var
	diropts -m0770 -o ${PN} -g ${PN}
	dodir /var/spool/postfix/${PN}
	keepdir /var/spool/postfix/${PN}
	fowners postgrey:postgrey /var/spool/postfix/${PN}
	fperms 0770 /var/spool/postfix/${PN}

	# postgrey binary
	dosbin ${PN}
	dosbin contrib/postgreyreport

	# policy-test script
	dosbin policy-test

	# postgrey data in /etc/postfix
	insinto /etc/postfix
	insopts -o root -g ${PN} -m 0640
	doins postgrey_whitelist_clients postgrey_whitelist_recipients

	# documentation
	dodoc Changes README

	# init.d + conf.d files
	insopts -o root -g root -m 755
	newinitd "${FILESDIR}"/${PN}.rc.new ${PN}
	insopts -o root -g root -m 640
	newconfd "${FILESDIR}"/${PN}.conf.new ${PN}
}

pkg_postinst() {
	echo
	elog "To make use of greylisting, please update your postfix config:"
	elog

	elog "In order to start using postgrey, edit /etc/conf.d/postgrey, add following lines"
	elog "to smtpd_recipient restrictions setting in your /etc/postfix/main.cf:"
	elog "\t\"check_policy_service inet:127.0.0.1:10030\", if you're using TCP socket"
	elog "\t\"check_policy_service unix:private/postgrey\", if you're using UNIX socket"
	elog "Then, start postgrey and restart postfix."

	elog "Also remember to make the daemon start durig system boot:"
	elog "  rc-update add postgrey default"

	if use targrey ; then
		elog "The targrey patch has been applied, read the"
		elog "documentation for more info at"
		elog "\thttp://k2net.hakuba.jp/targrey/index.en.html"
		elog
		elog "Activate targrey and set options using POSTGREY_OPTS in"
		elog "/etc/conf.d/postgrey"
		elog
	fi

	elog "Read postgrey documentation for more info (perldoc postgrey)."
}
