# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/shorewall/shorewall-2.0.10.ebuild,v 1.1 2004/11/21 10:17:55 eldad Exp $

IUSE="doc"

MY_P_DOCS=${P/${PN}/${PN}-docs-html}

DESCRIPTION="Full state iptables firewall"
HOMEPAGE="http://www.shorewall.net/"
SRC_URI="http://shorewall.net/pub/${PN}/2.0/${P}/${P}.tgz
	doc? ( http://shorewall.net/pub/${PN}/2.0/${P}/${MY_P_DOCS}.tgz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"

DEPEND="virtual/libc
	>=net-firewall/iptables-1.2.4
	sys-apps/iproute2"

S=${WORKDIR}/${MY_P}

src_install() {
	keepdir /var/lib/shorewall

	cd ${WORKDIR}/${P}
	PREFIX=${D} ./install.sh || die

	exeinto /etc/init.d
	newexe ${FILESDIR}/shorewall shorewall
	dodoc COPYING INSTALL changelog.txt releasenotes.txt
	if use doc; then
		cd ${WORKDIR}/${MY_P_DOCS}
		dohtml -r *
		dosym Documentation_Index.html /usr/share/doc/${PF}/html/index.htm
	fi
}

pkg_postinst() {
	einfo
	einfo "Read the documentation from http://www.shorewall.net"
	einfo "available at /usr/share/doc/${PF}/html/index.htm"
	einfo "Do not blindly start shorewall, edit the files in /etc/shorewall first"
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
}
