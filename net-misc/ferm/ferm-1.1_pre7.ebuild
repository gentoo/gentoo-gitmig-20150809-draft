# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ferm/ferm-1.1_pre7.ebuild,v 1.9 2004/07/15 02:49:19 agriffis Exp $

DESCRIPTION="Command line util for managing firewall rules"
HOMEPAGE="http://www.geo.vu.nl/~koka/ferm/"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "
IUSE=""
SLOT="0"
DEPEND=""
RDEPEND="dev-lang/perl"
SRC_URI="http://www.geo.vu.nl/~koka/ferm/${PN}.tar.gz"
S=${WORKDIR}/${PN}-1.1-pre7

src_install () {
	make PREFIX=${D}/usr DOCDIR="${D}/usr/share/doc/${PF}" install
}

pkg_postinst() {
	einfo "This package requires either iptables or ipchains."
	einfo "See /usr/share/doc/${PF}/examples for sample configs"
}
