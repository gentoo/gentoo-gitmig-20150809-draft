# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vmips/vmips-1.3.ebuild,v 1.1 2004/10/20 20:57:55 dholm Exp $

DESCRIPTION="A virtual machine simulator based on a MIPS R3000 processor"
HOMEPAGE="http://vmips.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc"
IUSE=""
DEPEND="app-emulation/vmips-cross-bin"

src_install() {
	einstall || die "einstall failed"
	dodoc README AUTHORS COPYING NEWS THANKS VERSION
}
