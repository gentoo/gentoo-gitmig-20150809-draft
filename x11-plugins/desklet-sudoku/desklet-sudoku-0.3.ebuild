# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-sudoku/desklet-sudoku-0.3.ebuild,v 1.6 2009/04/30 22:24:56 nixphoeni Exp $

DESKLET_NAME="Sudoku"

inherit gdesklets

S="${WORKDIR}"

DESCRIPTION="A small Sudoku board with support for downloading boards from websudoku.com"
HOMEPAGE="http://archive.gdesklets.info/"
SRC_URI="http://archive.gdesklets.info/${MY_P}.tar.gz"
LICENSE="as-is"

SLOT="0"
IUSE=""
KEYWORDS="~ia64 ~ppc ~x86 ~amd64"

RDEPEND=">=gnome-extra/gdesklets-core-0.35"
