# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/gridlock/gridlock-1.10.ebuild,v 1.1 2007/09/13 12:07:40 voyageur Exp $

inherit gnustep-2

S=${WORKDIR}/${PN/g/G}

DESCRIPTION="Gridlock is a collection of grid-based games"
HOMEPAGE="http://www.dozingcatsoftware.com/Gridlock/readme.html"
SRC_URI="http://www.dozingcatsoftware.com/Gridlock/${PN/g/G}-gnustep-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
