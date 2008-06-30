# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/six/six-0.5.3.ebuild,v 1.2 2008/06/30 06:22:27 mr_bones_ Exp $

ARTS_REQUIRED="yes"
inherit kde

DESCRIPTION="A Hex playing program for KDE"
HOMEPAGE="http://six.retes.hu/"
SRC_URI="http://six.retes.hu/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc ~sparc x86"
IUSE=""

PATCHES=( "${FILESDIR}/${P}-gcc43.patch" )

need-kde 3
