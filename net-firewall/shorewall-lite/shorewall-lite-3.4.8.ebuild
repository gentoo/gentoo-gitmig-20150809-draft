# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/shorewall-lite/shorewall-lite-3.4.8.ebuild,v 1.6 2008/05/16 13:44:39 armin76 Exp $

#MY_P_TREE="development/3.9"
MY_P_TREE="3.4"
MY_P="shorewall-${PV}"
MY_P_DOCS="${P/${PN}/shorewall-docs-html}"

DESCRIPTION="An iptables-based firewall whose config is handled by a normal Shorewall."
HOMEPAGE="http://www.shorewall.net/"
SRC_URI="http://www1.shorewall.net/pub/shorewall/${MY_P_TREE}/${MY_P}/${P}.tgz
	doc? ( http://www1.shorewall.net/pub/shorewall/${MY_P_TREE}/${MY_P}/${MY_P_DOCS}.tgz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa sparc x86"
IUSE="doc"

DEPEND="net-firewall/iptables
	sys-apps/iproute2"

src_compile() {
	einfo "Nothing to compile."
}

src_install() {
	keepdir /var/lib/shorewall-lite

	PREFIX="${D}" ./install.sh || die "install.sh failed"
	newinitd "${FILESDIR}/shorewall-lite" shorewall-lite

	dodoc changelog.txt releasenotes.txt
}

pkg_postinst() {
	elog
	elog "Documentation is available at http://www.shorewall.net"
	elog "There are man pages for shorewall-lite(8) and for each"
	elog "configuration file."
	elog
	elog "You should have already generated a firewall script with"
	elog "'shorewall compile' on the administrative Shorewall."
	elog "Please refer to"
	elog "http://www.shorewall.net/CompiledPrograms.html"
	elog
	elog "If you intend to use the 2.6 IPSEC Support, you must retrieve the"
	elog "kernel patches from http://shorewall.net/pub/shorewall/contrib/IPSEC/"
	elog "or install kernel 2.6.16+ as well as a recent Netfilter iptables"
	elog "and compile it with support for policy match."
	elog
	elog "Note that /etc/shorewall-lite/shorewall.conf has been renamed"
	elog "to /etc/shorewall-lite/shorewall-lite.conf"
	elog
	elog "Known problems:"
	elog "http://shorewall.net/pub/shorewall/${MY_P_TREE}/${MY_P}/known_problems.txt"
}
