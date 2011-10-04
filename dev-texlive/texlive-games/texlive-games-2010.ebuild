# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-games/texlive-games-2010.ebuild,v 1.7 2011/10/04 18:21:36 jer Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="cchess chess chess-problem-diagrams chessboard chessfss crossword crosswrd egameps go hexgame jeopardy othello psgo sgame skak skaknew sudoku sudokubundle xq xskak collection-games
"
TEXLIVE_MODULE_DOC_CONTENTS="chess-problem-diagrams.doc chessboard.doc chessfss.doc crossword.doc crosswrd.doc egameps.doc hexgame.doc jeopardy.doc othello.doc psgo.doc sgame.doc skak.doc skaknew.doc sudoku.doc sudokubundle.doc xq.doc xskak.doc "
TEXLIVE_MODULE_SRC_CONTENTS="chess-problem-diagrams.source chessboard.source chessfss.source crossword.source crosswrd.source go.source jeopardy.source sudoku.source sudokubundle.source xskak.source "
inherit texlive-module
DESCRIPTION="TeXLive Games typesetting"

LICENSE="GPL-2 as-is GPL-1 LPPL-1.3 public-domain "
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-latex-2010
!<dev-texlive/texlive-latexextra-2009
"
RDEPEND="${DEPEND} "
