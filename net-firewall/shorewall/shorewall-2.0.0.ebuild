# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/shorewall/shorewall-2.0.0.ebuild,v 1.2 2004/04/21 09:37:41 tigger Exp $

IUSE="doc"

MY_P_DOCS=${P/${PN}/${PN}-docs-html}

DESCRIPTION="Full state iptables firewall"
HOMEPAGE="http://www.shorewall.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz
	doc? ( mirror://sourceforge/${PN}/${MY_P_DOCS}.tgz )"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"

DEPEND="virtual/glibc
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
	if [ "`use doc`" ]; then
		cd ${WORKDIR}/${MY_P_DOCS}
		dohtml -r *
	fi
}

pkg_postinst() {
	einfo
	einfo "Read the documentation from http://www.shorewall.net"
	einfo "available at /usr/share/doc/${PF}/html/index.htm"
	einfo "Do not blindly start shorewall, edit the files in /etc/shorewall first"
	einfo
}
