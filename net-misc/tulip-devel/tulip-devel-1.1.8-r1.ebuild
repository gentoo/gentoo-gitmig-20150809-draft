# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tulip-devel/tulip-devel-1.1.8-r1.ebuild,v 1.3 2004/10/01 23:40:55 pyrania Exp $

inherit eutils

DESCRIPTION="Development version of the kernel driver for the Digital/Intel 21x4x ("Tulip") series of ethernet chips."
MY_PN="tulip"
MY_P=${MY_PN}-${PV}
HOMEPAGE="http://sourceforge.net/projects/${MY_PN}/"
SRC_URI="http://download.sourceforge.net/${MY_PN}/${MY_P}.tar.gz
	mirror://sourceforge/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc"

IUSE=""
DEPEND=">=virtual/kernel-2.3.50"

S=${WORKDIR}/${MY_P}/src

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-${PR}-gentoo.patch || die "epatch failed."
}

src_compile() {
	make || die
}

src_install() {
	check_KV
	insinto /lib/modules/$KV/kernel/drivers/net/tulip
	newins tulip.o tulip-devel.o
	dodoc ChangeLog

	echo
	einfo "The development version of the tulip module has been installed"
	einfo "as /lib/modules/$KV/kernel/drivers/net/tulip/tulip-devel.o."
	einfo "If you upgrade or downgrade your kernel, you will need to"
	einfo "remerge this ebuild by typing 'emerge ${PN}'."
	echo
}
