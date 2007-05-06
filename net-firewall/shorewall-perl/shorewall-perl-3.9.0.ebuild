# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/shorewall-perl/shorewall-perl-3.9.0.ebuild,v 1.2 2007/05/06 10:02:55 genone Exp $

DESCRIPTION="Shoreline Firewall Perl-based compiler that allows faster compilation and execution."
HOMEPAGE="http://www.shorewall.net/"
SRC_URI="http://www1.shorewall.net/pub/shorewall/development/3.9/${P}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-firewall/iptables
	sys-apps/iproute2
	dev-lang/perl
	>=net-firewall/shorewall-3.4.2"

src_compile() {
	einfo "Nothing to compile."
}

src_install() {
	PREFIX="${D}" ./install.sh || die "install.sh failed"

	dodoc releasenotes.txt
}

pkg_postinst() {
	elog
	elog "Documentation is available at http://www.shorewall.net"
	elog
	elog "In order to use the Perl compiler you need to add"
	elog "SHOREWALL_COMPILER=perl"
	elog "to shorewall.conf"
	elog
	elog "Please read the included release notes for more information."
	elog
	elog "Known problems:"
	elog "http://www1.shorewall.net/pub/shorewall/development/3.9/${P}/known_problems.txt"
}
