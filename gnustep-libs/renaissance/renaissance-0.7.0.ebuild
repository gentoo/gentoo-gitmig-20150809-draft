# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/renaissance/renaissance-0.7.0.ebuild,v 1.2 2004/07/23 15:01:54 fafhrd Exp $

inherit gnustep-old

S=${WORKDIR}/${P/r/R}

DESCRIPTION="GNUstep xml-based UI toolkit"
HOMEPAGE="http://www.gnustep.org"
SRC_URI="http://www.gnustep.it/Renaissance/Download/${P/r/R}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc"
DEPEND=">=gnustep-base/gnustep-gui-0.8.5"
IUSE=""

src_compile() {
	addwrite ~/GNUstep/Library/Services/.GNUstepAppList
	egnustepmake
}
