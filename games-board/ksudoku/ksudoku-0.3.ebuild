# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ksudoku/ksudoku-0.3.ebuild,v 1.1 2006/04/03 15:33:32 jokey Exp $

inherit kde

DESCRIPTION="Sudoku Puzzle Generator and Solver for KDE"
HOMEPAGE="http://ksudoku.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

need-kde 3.3
