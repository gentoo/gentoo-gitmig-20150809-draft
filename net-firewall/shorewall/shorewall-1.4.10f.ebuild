# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/shorewall/shorewall-1.4.10f.ebuild,v 1.7 2004/07/14 23:47:21 agriffis Exp $

IUSE="doc"

DESCRIPTION="Full state iptables firewall"
HOMEPAGE="http://www.shorewall.net/"
SRC_URI="ftp://slovakia.shorewall.net/mirror/${PN}/${P}/${P}.tgz
	doc? ( ftp://slovakia.shorewall.net/mirror/${PN}/${P}/${PN}-docs-html-${PV}.tgz )"
#RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha ~amd64"

DEPEND="virtual/libc
	net-firewall/iptables
	sys-apps/iproute2"

src_install() {
	keepdir /var/lib/shorewall
	PREFIX=${D} ./install.sh /etc/init.d || die

	exeinto /etc/init.d
	newexe ${FILESDIR}/shorewall shorewall
	dodoc COPYING INSTALL changelog.txt releasenotes.txt
	if use doc; then
		cd ${WORKDIR}/${PN}-docs-html-${PV}
		dohtml -r *
	fi
}

pkg_postinst() {
	einfo "Read the documentation from http://www.shorewall.net"
	einfo "available at /usr/share/doc/${PF}/html/index.htm"
	einfo "and edit the files in /etc/shorewall before starting the firewall"
}
