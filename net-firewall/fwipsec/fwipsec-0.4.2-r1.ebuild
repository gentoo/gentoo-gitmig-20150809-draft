# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/fwipsec/fwipsec-0.4.2-r1.ebuild,v 1.6 2007/05/06 09:44:06 genone Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Firewall scripts that control iptables, FreeS/WAN, and squid."
HOMEPAGE="http://www.fwipsec.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="alpha amd64 ~hppa ia64 ~mips ~ppc ~sparc x86"

DEPEND="virtual/linux-sources
		>=net-firewall/iptables-1.2.7
		sys-apps/iproute2"

src_install() {
	exeinto /etc/fwipsec
	doexe fwipsec.*
	doinitd fwipsec

	dodoc LICENSE DOCS/README*
	doman DOCS/*.5
}

pkg_postinst() {
	elog "Edit /etc/fwipsec/fwipsec.defs to set your base rules."
}
