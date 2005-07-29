# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/isic/isic-0.06.ebuild,v 1.5 2005/07/29 23:50:49 dragonheart Exp $

inherit eutils

DESCRIPTION="IP Stack Integrity Checker"
HOMEPAGE="http://www.packetfactory.net/projects/ISIC/"
SRC_URI="http://www.packetfactory.net/projects/ISIC/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND=">=net-libs/libnet-1.1"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-makefile.patch
	epatch ${FILESDIR}/${P}-gcc4.patch
}

src_compile() {
	econf --bindir=/usr/bin || die "configure died"
	emake || die "make died"
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc README
}
