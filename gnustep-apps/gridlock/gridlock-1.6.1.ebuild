# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/gridlock/gridlock-1.6.1.ebuild,v 1.2 2004/07/23 14:58:21 fafhrd Exp $

inherit gnustep-old

S=${WORKDIR}/${PN/g/G}

DESCRIPTION="Gridlock is a collection of grid-based games"
HOMEPAGE="http://dozingcat.com/"
SRC_URI="http://dozingcat.com/Gridlock/${PN/g/G}-GNUstep-${PV}.tar.gz"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND=">=gnustep-base/gnustep-gui-0.8.5"

src_unpack() {
	unpack ${PN/g/G}-GNUstep-${PV}.tar.gz
	cd ${S}
}
