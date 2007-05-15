# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-sudoku/vdr-sudoku-0.1.3.ebuild,v 1.2 2007/05/15 20:42:25 zzam Exp $

inherit vdr-plugin

DESCRIPTION="Sudoku is a VDR plugin to generate and solve Number Place puzzles, so called Sudokus."
HOMEPAGE="http://toms-cafe.de/vdr/sudoku/sudoku.de.html"
SRC_URI="http://toms-cafe.de/vdr/sudoku/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="media-video/vdr"
