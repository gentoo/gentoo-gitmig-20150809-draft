# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/kwin-neos/kwin-neos-0.2b.ebuild,v 1.2 2004/08/30 19:44:42 pvdabeel Exp $

inherit kde

DESCRIPTION="A native KWin window decoration for KDE 3.2.x"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=12125"
SRC_URI="http://perso.wanadoo.fr/chamayou/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

need-kde 3.2
