# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-games/texlive-games-2007.ebuild,v 1.12 2008/04/08 05:28:44 jer Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-latex
"
TEXLIVE_MODULE_CONTENTS="backgammon bridge cchess cheq chess egameps go othello psgo sgame skak skaknew sudoku sudokubundle xq collection-games
"
inherit texlive-module
DESCRIPTION="TeXLive Games typesetting (chess, etc)"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~ia64 ~ppc ppc64 ~sparc x86 ~x86-fbsd"
