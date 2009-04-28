# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-sudoku/desklet-sudoku-0.3.ebuild,v 1.4 2009/04/28 01:35:37 nixphoeni Exp $

DESKLET_NAME="Sudoku"

inherit gdesklets

S="${WORKDIR}"

DESCRIPTION="A small Sudoku board with support for downloading boards from websudoku.com"
HOMEPAGE="http://www.gdesklets.org/?mod=project/uview&pid=15"
SRC_URI="http://www.gdesklets.org/projects/15/releases/${MY_P}.tar.gz"
LICENSE="as-is"

SLOT="0"
IUSE=""
KEYWORDS="~ia64 ~ppc ~x86"

RDEPEND=">=gnome-extra/gdesklets-core-0.35"
