# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/terminal/terminal-0.9.4.ebuild,v 1.2 2004/07/23 14:59:59 fafhrd Exp $

inherit gnustep-old

S=${WORKDIR}/${P/t/T}

DESCRIPTION="GNUstep terminal emulator"
HOMEPAGE="http://www.nongnu.org/terminal/"
SRC_URI="http://savannah.nongnu.org/download/terminal/Terminal.pkg/${PV}/${P/t/T}.tar.gz"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=gnustep-base/gnustep-gui-0.8.5"

src_unpack() {
	unpack ${P/t/T}.tar.gz
	cd ${S}
}
