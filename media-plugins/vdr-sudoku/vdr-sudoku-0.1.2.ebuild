# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-sudoku/vdr-sudoku-0.1.2.ebuild,v 1.1 2006/04/26 14:57:28 zzam Exp $

inherit vdr-plugin

DESCRIPTION="Sudoku is a VDR plugin to generate and solve Number Place puzzles, so called Sudokus."
HOMEPAGE="http://toms-cafe.de/vdr/sudoku/sudoku.de.html"
SRC_URI="http://toms-cafe.de/vdr/sudoku/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND="media-video/vdr"
