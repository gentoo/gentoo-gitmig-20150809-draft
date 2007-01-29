# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/kwin-neos/kwin-neos-0.2b.ebuild,v 1.6 2007/01/29 02:33:22 mr_bones_ Exp $

inherit kde flag-o-matic

DESCRIPTION="A native KWin window decoration for KDE 3.2.x"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=12125"
SRC_URI="http://perso.wanadoo.fr/chamayou/${P}.tar.bz2
	mirror://gentoo/kde-admindir-3.5.3.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

need-kde 3.2

src_compile() {
	append-flags -fno-strict-aliasing # breaks strict aliasing
	kde_src_compile
}
