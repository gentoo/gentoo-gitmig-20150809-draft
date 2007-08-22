# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/gmines/gmines-0.1-r1.ebuild,v 1.4 2007/08/22 16:28:02 uberlord Exp $

inherit gnustep

S=${WORKDIR}/${PN/gm/GM}

DESCRIPTION="The well-known minesweeper game."
HOMEPAGE="http://www.gnustep.it/marko/GMines/index.html"
SRC_URI="http://www.gnustep.it/marko/GMines/${PN/gm/GM}.tgz"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
SLOT="0"
LICENSE="GPL-2"

IUSE=""
DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}"

egnustep_install_domain "Local"
