# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/nestra/nestra-0.66.ebuild,v 1.2 2003/02/13 07:14:57 vapier Exp $

S=${WORKDIR}/nestra/
IUSE=""
SLOT="0"
DESCRIPTION="NES Emulator"
HOMEPAGE="http://nestra.linuxgames.com"
KEYWORDS="x86"
SRC_URI="http://nestra.linuxgames.com/${P}.tar.gz"
LICENSE="as-is"

src_compile() {
	emake || die
}

src_install() {
	dobin nestra
	dodoc README CHANGES BUGS
}
