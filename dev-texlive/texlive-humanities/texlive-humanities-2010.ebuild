# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-humanities/texlive-humanities-2010.ebuild,v 1.5 2011/08/14 18:11:51 maekke Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="alnumsec arydshln bibleref covington dramatist ecltree ednotes gb4e gmverse jura juraabbrev juramisc jurarsp ledmac lexikon lineno linguex liturg parallel parrun plari play poemscol qobitree qtree rtklage screenplay sides stage tree-dvips verse xyling collection-humanities
"
TEXLIVE_MODULE_DOC_CONTENTS="alnumsec.doc arydshln.doc bibleref.doc covington.doc dramatist.doc ecltree.doc ednotes.doc gb4e.doc gmverse.doc jura.doc juraabbrev.doc juramisc.doc jurarsp.doc ledmac.doc lexikon.doc lineno.doc linguex.doc liturg.doc parallel.doc parrun.doc plari.doc play.doc poemscol.doc qobitree.doc qtree.doc rtklage.doc screenplay.doc sides.doc stage.doc tree-dvips.doc verse.doc xyling.doc "
TEXLIVE_MODULE_SRC_CONTENTS="alnumsec.source arydshln.source bibleref.source dramatist.source jura.source juraabbrev.source jurarsp.source ledmac.source liturg.source parallel.source parrun.source plari.source play.source poemscol.source screenplay.source tree-dvips.source verse.source "
inherit texlive-module
DESCRIPTION="TeXLive Humanities packages"

LICENSE="GPL-2 as-is GPL-1 LPPL-1.2 LPPL-1.3 public-domain "
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-latex-2010
!dev-tex/lineno
"
RDEPEND="${DEPEND} "
