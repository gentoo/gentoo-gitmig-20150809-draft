# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/isic/isic-0.05.ebuild,v 1.3 2003/07/13 11:30:12 aliz Exp $

DESCRIPTION="IP Stack Integrity Checker"
HOMEPAGE="http://www.packetfactory.net/projects/ISIC/"
SRC_URI="http://www.packetfactory.net/projects/ISIC/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"

DEPEND="=net-libs/libnet-1.0*"

src_compile() {
	env WANT_AUTOCONF_2_5=1 autoconf || die
	econf || die
	emake || die
}

src_install() {
	make install PREFIX=${D}/usr || die
	dodoc README
}
