# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-sudoku/vdr-sudoku-0.3.5.ebuild,v 1.3 2011/12/21 08:43:15 phajdan.jr Exp $

EAPI="2"

inherit vdr-plugin

DESCRIPTION="VDR plugin: to generate and solve Number Place puzzles, so called Sudokus."
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-sudoku"
SRC_URI="http://projects.vdr-developer.org/attachments/download/280/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0"
