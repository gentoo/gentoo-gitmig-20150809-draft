# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/fwipsec/fwipsec-0.4.2-r1.ebuild,v 1.2 2005/04/01 15:00:50 agriffis Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Firewall scripts that control iptables, FreeS/WAN, and squid."
HOMEPAGE="http://www.fwipsec.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86 ~ppc ~sparc ~alpha amd64 ~hppa ~mips ia64"

DEPEND="virtual/linux-sources
		>=net-firewall/iptables-1.2.7
		sys-apps/iproute2"

src_install() {
	exeinto /etc/fwipsec
	doexe fwipsec.*
	exeinto /etc/init.d
	doexe fwipsec

	dodoc LICENSE DOCS/README*
	doman DOCS/*.5
}

pkg_postinst() {
	einfo "Edit /etc/fwipsec/fwipsec.defs to set your base rules."
	echo
}
