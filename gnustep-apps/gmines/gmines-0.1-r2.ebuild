# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/gmines/gmines-0.1-r2.ebuild,v 1.2 2008/01/25 17:37:45 opfer Exp $

inherit gnustep-2

S=${WORKDIR}/${PN/gm/GM}

DESCRIPTION="The well-known minesweeper game."
HOMEPAGE="http://www.gnustep.it/marko/GMines/index.html"
SRC_URI="http://www.gnustep.it/marko/GMines/${PN/gm/GM}.tgz"
KEYWORDS="~amd64 ~ppc x86 ~x86-fbsd"
SLOT="0"
LICENSE="GPL-2"
