# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/ksudoku/ksudoku-0.3.ebuild,v 1.2 2006/05/01 11:06:30 corsair Exp $

inherit kde

DESCRIPTION="Sudoku Puzzle Generator and Solver for KDE"
HOMEPAGE="http://ksudoku.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

need-kde 3.3
