# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-sudoku/vdr-sudoku-0.3.5.ebuild,v 1.4 2012/02/07 14:15:47 hd_brummy Exp $

EAPI="3"

inherit vdr-plugin

VERSION="280" # every bump, new version

DESCRIPTION="VDR plugin: to generate and solve Number Place puzzles, so called Sudokus."
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-sudoku"
SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0"
RDEPEND="${DEPEND}"
