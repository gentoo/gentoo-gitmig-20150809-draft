# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/shorewall/shorewall-2.2.2.ebuild,v 1.1 2005/03/24 00:47:52 vanquirius Exp $

MY_P_DOCS="${P/${PN}/${PN}-docs-html}"

DESCRIPTION="Full state iptables firewall"
HOMEPAGE="http://www.shorewall.net/"
SRC_URI="http://shorewall.net/pub/${PN}/2.2/${P}/${P}.tgz
	doc? ( http://shorewall.net/pub/${PN}/2.2/${P}/${MY_P_DOCS}.tgz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"
IUSE="doc"

DEPEND="virtual/libc
	>=net-firewall/iptables-1.2.4
	sys-apps/iproute2"

src_install() {
	keepdir /var/lib/shorewall

	PREFIX="${D}" ./install.sh || die "install.sh failed"
	doinitd ${FILESDIR}/shorewall || die "doinitd failed"

	dodoc COPYING INSTALL changelog.txt releasenotes.txt
	if use doc; then
		cd ${WORKDIR}/${MY_P_DOCS}
		dohtml -r *
		dosym Documentation_Index.html /usr/share/doc/${PF}/html/index.htm
	fi
}

pkg_postinst() {
	echo

	if use doc ; then
		einfo "Documentation is available at /usr/share/doc/${PF}/html"
	else
		einfo "Documentation is available at http://www.shorewall.net"
	fi

	einfo "Do not blindly start shorewall, edit the files in /etc/shorewall first"
	einfo "At the very least, you must change 'STARTUP_ENABLED' in shorewall.conf"
	einfo
	einfo "Information on upgrading is available at:"
	einfo "  http://www.shorewall.net/errata.htm#Upgrade"
	einfo
	einfo "If you have just upgraded from shorewall-2.0.1 mark the following issues:"
	einfo
	einfo "1. Extension Scripts -- In order for extension scripts to work properly"
	einfo "   with the new iptables-save/restore integration, some change may be"
	einfo "   required to your extension scripts if they are executing commands"
	einfo "   other than iptables."
	einfo
	einfo "2. Dynamic Zone support -- If you don't need to use the 'shorewall add'"
	einfo "   and 'shorewall delete' commands, you should set DYNAMIC_ZONES=No"
	einfo "   in /etc/shorewall/shorewall.conf"
	einfo
	einfo "See the shorewall documentation for more details."
	einfo
	einfo "If you intend to use the 2.6 IPSEC Support, you must retrieve the"
	einfo "kernel patches from http://shorewall.net/pub/shorewall/contrib/IPSEC/"
	echo
}
