# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/kamikaze/kamikaze-0.2.2.ebuild,v 1.2 2006/04/24 11:31:34 tupone Exp $

inherit kde

DESCRIPTION="A bomberman like game for KDE"
HOMEPAGE="http://kamikaze.coolprojects.org/"
SRC_URI="http://kamikaze.coolprojects.org/download/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 ppc ~sparc x86"
SLOT="0"
IUSE=""

PATCHES="${FILESDIR}/${P}"-gcc41.patch

need-kde 3
