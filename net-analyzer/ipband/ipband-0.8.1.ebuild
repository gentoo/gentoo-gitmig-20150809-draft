# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ipband/ipband-0.8.1.ebuild,v 1.1 2008/12/06 19:48:18 dertobi123 Exp $

inherit eutils

DESCRIPTION="A pcap based IP traffic and bandwidth monitor with configurable reporting and alarm abilities"
HOMEPAGE="http://ipband.sourceforge.net/"
SRC_URI="http://ipband.sourceforge.net/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=net-libs/libpcap-0.4"

src_unpack() {
	unpack ${A}

	# Provide a postfix MTA string in the author's ipband.conf example
	sed -rie 's:(#mtastring.*):# Sendmail\n\1\n# Postfix\n#mtastring "/usr/sbin/sendmail -t":g' \
		"${S}"/ipband.sample.conf
}

src_compile() {
	emake || die "Compile problem"
}

src_install() {
	doman ipband.8
	dodoc CHANGELOG README
	exeinto /usr/bin ; doexe ipband
	newinitd "${FILESDIR}"/ipband-init ipband
	insinto /etc/ ; newins ipband.sample.conf ipband.conf
}

pkg_postinst() {
	ewarn "If you plan to use ipband as a service, you must edit"
	ewarn "/etc/ipband.conf"
	elog ""
	elog "The following command line example will:"
	elog "  o Listen on eth0"
	elog "  o Group results into a summary relative to 192.168.1.0/24"
	elog "  o Average bandwidth every 5 seconds"
	elog "  o Report when average bandwidth has exceeded 7 kB/sec"
	elog "    over the previous 10 seconds. The report is written to"
	elog "    stdout but can also be emailed or stored in a file."
	elog ""
	elog "ipband eth0 -L 192.168.1.0/24 -a 5 -r 10 -b 7 -o -"
}
