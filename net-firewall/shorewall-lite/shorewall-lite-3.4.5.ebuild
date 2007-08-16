# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/shorewall-lite/shorewall-lite-3.4.5.ebuild,v 1.2 2007/08/16 22:17:52 gustavoz Exp $

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
KEYWORDS="~amd64 ~hppa sparc ~x86"
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
	einfo
	einfo "Documentation is available at http://www.shorewall.net"
	einfo "There are man pages for shorewall-lite(8) and for each"
	einfo "configuration file."
	einfo
	einfo "You should have already generated a firewall script with"
	einfo "'shorewall compile' on the administrative Shorewall."
	einfo "Please refer to"
	einfo "http://www.shorewall.net/CompiledPrograms.html"
	einfo
	einfo "If you intend to use the 2.6 IPSEC Support, you must retrieve the"
	einfo "kernel patches from http://shorewall.net/pub/shorewall/contrib/IPSEC/"
	einfo "or install kernel 2.6.16+ as well as a recent Netfilter iptables"
	einfo "and compile it with support for policy match."
	einfo
	einfo "Note that /etc/shorewall-lite/shorewall.conf has been renamed"
	einfo "to /etc/shorewall-lite/shorewall-lite.conf"
	einfo
	einfo "Known problems:"
	einfo "http://shorewall.net/pub/shorewall/${MY_P_TREE}/${MY_P}/known_problems.txt"
}
