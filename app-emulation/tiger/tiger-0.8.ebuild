# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/tiger/tiger-0.8.ebuild,v 1.7 2004/09/01 10:57:28 sekretarz Exp $

inherit eutils gcc

DESCRIPTION="Ti-92 Graphing Calculator Emulator"
HOMEPAGE="http://xtiger.sourceforge.net/"
SRC_URI="http://xtiger.sourceforge.net/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="virtual/libc
	media-libs/libggi"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc34.patch
}

src_compile() {
	emake || die
}

src_install() {
	dobin tiger || die
	dodoc AUTHORS ChangeLog HACKING INSTALL README
	doman debian/tiger.1
}
