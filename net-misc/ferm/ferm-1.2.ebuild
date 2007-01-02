# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ferm/ferm-1.2.ebuild,v 1.1 2007/01/02 19:29:19 masterdriverz Exp $

DESCRIPTION="Command line util for managing firewall rules"
HOMEPAGE="http://ferm.foo-projects.org/"
SRC_URI="http://ferm.foo-projects.org/download/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~ppc ~sparc ~x86"
IUSE=""
SLOT="0"

DEPEND=""
RDEPEND="dev-lang/perl
	|| ( net-firewall/iptables net-firewall/ipchains )"

src_install () {
	make PREFIX=${D}/usr DOCDIR="${D}/usr/share/doc/${PF}" install || die 'make	install failed'
}

pkg_postinst() {
	einfo "See /usr/share/doc/${PF}/examples for sample configs"
}
