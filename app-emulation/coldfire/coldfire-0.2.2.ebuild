# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/coldfire/coldfire-0.2.2.ebuild,v 1.1 2005/03/17 01:19:16 vapier Exp $

DESCRIPTION="Motorola Coldfire Emulator"
HOMEPAGE="http://www.slicer.ca/coldfire/"
SRC_URI="http://www.slicer.ca/coldfire/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

src_compile() {
	econf || die
	emake -j1 || die
}

src_install() {
	dodir /usr/bin
	einstall || die
	dodoc AUTHORS HACKING README
}
