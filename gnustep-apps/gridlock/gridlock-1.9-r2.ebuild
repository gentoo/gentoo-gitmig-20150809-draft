# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/gridlock/gridlock-1.9-r2.ebuild,v 1.1 2007/09/11 11:18:17 voyageur Exp $

inherit gnustep-2

S=${WORKDIR}/${PN/g/G}

DESCRIPTION="Gridlock is a collection of grid-based games"
# 25 Mar 2006: upstream appears to be dead
HOMEPAGE="http://dozingcat.com/"
SRC_URI="mirror://gentoo/${PN/g/G}-gnustep-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Needed for newer make
	rm ./obj
}
