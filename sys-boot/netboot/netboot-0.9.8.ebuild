# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/netboot/netboot-0.9.8.ebuild,v 1.1 2004/10/06 05:40:12 zhen Exp $

inherit eutils

DESCRIPTION="x86 specific netbooting utility"
HOMEPAGE="http://netboot.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="-* ~x86"
IUSE=""

DEPEND="sys-devel/autoconf"
#RDEPEND=""

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc README version
	cp -a FlashCard ${D}/usr/share/doc/${P}
}
