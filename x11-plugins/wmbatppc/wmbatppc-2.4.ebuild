# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbatppc/wmbatppc-2.4.ebuild,v 1.2 2004/07/25 19:02:06 s4t4n Exp $

inherit eutils

DESCRIPTION="small battery-monitoring dockapp for G3/G4 laptops"
HOMEPAGE="http://titelou.free.fr/wmbatppc/"
SRC_URI="http://titelou.free.fr/wmbatppc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ppc"
IUSE=""

DEPEND="virtual/x11
	>=app-laptop/pmud-0.10.1-r2
	>=x11-libs/xosd-2.2.5-r1"

src_unpack()
{
	unpack ${A}
	cd ${S}

	# Make it honour Gentoo CFLAGS
	epatch ${FILESDIR}/wmbatppc-2.4-cflags.patch
}

src_compile()
{
	emake || die "Compilation failed"
}

src_install()
{
	dobin wmbatppc || die
	doman wmbatppc.1
}
