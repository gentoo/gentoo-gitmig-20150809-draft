# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/dlx/dlx-1.0.0.ebuild,v 1.3 2004/03/02 21:09:46 dholm Exp $

S=${WORKDIR}/dlx
DESCRIPTION="DLX Simulator"
HOMEPAGE="http://www.davidviner.com/dlx.php"
SRC_URI="http://www.davidviner.com/dlx/dlx.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""
DEPEND=""

src_compile() {
	emake || die
}

src_install() {
	dobin masm mon dasm
	dodoc README.txt MANUAL.TXT
}
