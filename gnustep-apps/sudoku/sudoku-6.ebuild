# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/sudoku/sudoku-6.ebuild,v 1.3 2008/01/30 01:36:34 ranger Exp $

inherit gnustep-2

MY_PN="${PN/s/S}"
S="${WORKDIR}/${MY_PN}${PV}"

DESCRIPTION="Sudoku generator for GNUstep"
HOMEPAGE="http://www.gnustep.it/marko/Sudoku"
SRC_URI="http://www.gnustep.it/marko/${MY_PN}/${MY_PN}${PV}.tgz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ppc x86"
SLOT="0"
