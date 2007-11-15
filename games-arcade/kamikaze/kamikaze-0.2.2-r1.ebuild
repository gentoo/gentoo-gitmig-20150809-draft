# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/kamikaze/kamikaze-0.2.2-r1.ebuild,v 1.2 2007/11/15 19:08:19 drac Exp $

inherit kde

DESCRIPTION="A bomberman like game for KDE"
HOMEPAGE="http://kamikaze.coolprojects.org/"
SRC_URI="http://kamikaze.coolprojects.org/download/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ppc x86"
SLOT="0"
IUSE=""

DEPEND=">=dev-games/ggz-client-libs-0.0.13"

need-kde 3
