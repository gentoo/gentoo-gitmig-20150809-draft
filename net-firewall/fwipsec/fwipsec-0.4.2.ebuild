# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Id: fwipsec-0.4.2.ebuild,v 1.1 2004/06/04 19:51:08 seemant Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Firewall scripts that control iptables, FreeS/WAN, and squid."
HOMEPAGE="http://www.fwipsec.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 ~hppa ~mips ~ia64"

DEPEND="virtual/linux-sources
		>=net-firewall/iptables-1.2.7
		sys-apps/iproute2"

src_install() {
	exeinto /etc/fwipsec
	doexe fwipsec.*
	exeinto /etc/init.d
	doexe fwipsec

	dodoc LICENSE DOCS/*
}

pkg_postinst() {
	einfo "Edit /etc/fwipsec/fwipsec.defs to set your base rules."
	echo
}
