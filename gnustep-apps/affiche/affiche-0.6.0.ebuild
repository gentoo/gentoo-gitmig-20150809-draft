# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/affiche/affiche-0.6.0.ebuild,v 1.1 2004/07/22 22:01:02 fafhrd Exp $

inherit gnustep-old

S=${WORKDIR}/${PN/a/A}

DESCRIPTION="Affiche allows people to 'stick' notes"
HOMEPAGE="http://www.collaboration-world.com/cgi-bin/collaboration-world/project/release.cgi?pid=5"
SRC_URI="http://www.collaboration-world.com/affiche.data/releases/Stable/${P/a/A}.tar.gz"
IUSE=""
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND=">=dev-util/gnustep-gui-0.8.5"

src_unpack() {
	unpack ${P/a/A}.tar.gz
	cd ${S}
}
