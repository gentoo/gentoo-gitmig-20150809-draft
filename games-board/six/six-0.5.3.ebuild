# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/six/six-0.5.3.ebuild,v 1.5 2009/08/18 00:19:50 mr_bones_ Exp $

ARTS_REQUIRED="yes"
inherit kde

DESCRIPTION="A Hex playing program for KDE"
HOMEPAGE="http://six.retes.hu/"
SRC_URI="http://six.retes.hu/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE=""

PATCHES=( "${FILESDIR}/${P}-gcc43.patch" )

DEPEND="!dev-scheme/gambit" # bug #272633

need-kde 3

src_unpack() {
	kde_src_unpack
	cd "${S}"
	echo "Categories=Qt;KDE;Game;BoardGame;" >> six/six.desktop
}
