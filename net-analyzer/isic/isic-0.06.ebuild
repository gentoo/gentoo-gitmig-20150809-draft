# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/isic/isic-0.06.ebuild,v 1.3 2005/04/10 18:08:03 vanquirius Exp $

inherit eutils

DESCRIPTION="IP Stack Integrity Checker"
HOMEPAGE="http://www.packetfactory.net/projects/ISIC/"
SRC_URI="http://www.packetfactory.net/projects/ISIC/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=net-libs/libnet-1.1"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-makefile.patch || die "patch failed"
	epatch ${FILESDIR}/${P}-gcc4.patch || die "patch failed"
}

src_compile() {
	econf --bindir=/usr/bin || die "configure died"
	emake || die "make died"
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc README
}
