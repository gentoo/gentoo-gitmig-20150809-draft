# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-sudoku/vdr-sudoku-0.3.4.ebuild,v 1.2 2009/03/12 19:03:28 zzam Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: to generate and solve Number Place puzzles, so called Sudokus."
HOMEPAGE="http://toms-cafe.de/vdr/sudoku/"
SRC_URI="http://toms-cafe.de/vdr/sudoku/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="media-video/vdr"
