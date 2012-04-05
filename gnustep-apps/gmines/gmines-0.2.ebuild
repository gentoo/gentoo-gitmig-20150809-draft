# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/gmines/gmines-0.2.ebuild,v 1.2 2012/04/05 09:33:58 ago Exp $

EAPI=4
inherit gnustep-2

DESCRIPTION="The well-known minesweeper game."
HOMEPAGE="http://gap.nongnu.org/gmines/index.html"
SRC_URI="http://savannah.nongnu.org/download/gap/${P/gm/GM}.tar.gz"
KEYWORDS="amd64 ~ppc ~x86 ~x86-fbsd"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

S=${WORKDIR}/${P/gm/GM}
