# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ferm/ferm-1.1_pre7.ebuild,v 1.4 2002/08/14 12:08:07 murphy Exp $

DESCRIPTION="Command line util for managing firewall rules"
HOMEPAGE="http://www.geo.vu.nl/~koka/ferm/"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"
SLOT="0"
DEPEND=""
RDEPEND="sys-devel/perl"
SRC_URI="http://www.geo.vu.nl/~koka/ferm/${PN}.tar.gz"
S=${WORKDIR}/${PN}-1.1-pre7

src_install () {
	make PREFIX=${D}/usr DOCDIR="${D}/usr/share/doc/${PF}" install
}

pkg_postinst() {
	einfo "This package requires either iptables or ipchains."
	einfo "See /usr/share/doc/${PF}/examples for sample configs"
}
