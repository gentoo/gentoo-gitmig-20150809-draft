# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-games/texlive-games-2008.ebuild,v 1.11 2009/06/10 14:05:49 alexxy Exp $

TEXLIVE_MODULE_CONTENTS="backgammon bridge cchess chess chessboard chessfss egameps go hexgame jeopardy othello psgo sgame skak skaknew sudoku sudokubundle xq xskak collection-games
"
TEXLIVE_MODULE_DOC_CONTENTS="backgammon.doc chessboard.doc chessfss.doc egameps.doc hexgame.doc jeopardy.doc othello.doc psgo.doc sgame.doc skak.doc skaknew.doc sudoku.doc sudokubundle.doc xq.doc xskak.doc "
TEXLIVE_MODULE_SRC_CONTENTS="backgammon.source chessboard.source chessfss.source go.source jeopardy.source othello.source sudoku.source sudokubundle.source xskak.source "
inherit texlive-module
DESCRIPTION="TeXLive Games typesetting (chess, etc)"

LICENSE="GPL-2 as-is freedist GPL-1 LPPL-1.3 public-domain "
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-latex-2008
"
RDEPEND="${DEPEND}"
