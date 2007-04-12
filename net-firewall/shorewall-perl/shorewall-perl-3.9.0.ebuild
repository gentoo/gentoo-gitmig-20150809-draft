# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/shorewall-perl/shorewall-perl-3.9.0.ebuild,v 1.1 2007/04/12 19:17:06 jokey Exp $

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
	einfo
	einfo "Documentation is available at http://www.shorewall.net"
	einfo
	einfo "In order to use the Perl compiler you need to add"
	einfo "SHOREWALL_COMPILER=perl"
	einfo "to shorewall.conf"
	einfo
	einfo "Please read the included release notes for more information."
	einfo
	einfo "Known problems:"
	einfo "http://www1.shorewall.net/pub/shorewall/development/3.9/${P}/known_problems.txt"
}
