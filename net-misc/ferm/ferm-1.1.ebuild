# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ferm/ferm-1.1.ebuild,v 1.4 2005/01/27 22:17:39 lanius Exp $

DESCRIPTION="Command line util for managing firewall rules"
HOMEPAGE="http://ferm.sf.net"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~ppc"
IUSE=""
SLOT="0"
DEPEND=""
RDEPEND="dev-lang/perl
	|| ( net-firewall/iptables net-firewall/ipchains )"
SRC_URI="http://ferm.sourceforge.net/${P}.tar.gz"

src_install () {
	make PREFIX=${D}/usr DOCDIR="${D}/usr/share/doc/${PF}" install
}

pkg_postinst() {
	einfo "See /usr/share/doc/${PF}/examples for sample configs"
}
