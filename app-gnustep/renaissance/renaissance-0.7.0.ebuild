# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-gnustep/renaissance/renaissance-0.7.0.ebuild,v 1.2 2004/02/18 09:44:23 dholm Exp $

inherit gnustep

S=${WORKDIR}/${P/r/R}

DESCRIPTION="GNUstep xml-based UI toolkit"
HOMEPAGE="http://www.gnustep.org"
SRC_URI="http://www.gnustep.it/Renaissance/Download/${P/r/R}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc"
DEPEND=">=dev-util/gnustep-gui-0.8.5"

src_compile() {
	addwrite ~/GNUstep/Library/Services/.GNUstepAppList
	egnustepmake
}
