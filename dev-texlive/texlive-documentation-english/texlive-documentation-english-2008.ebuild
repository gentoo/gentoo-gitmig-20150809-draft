# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-english/texlive-documentation-english-2008.ebuild,v 1.11 2009/06/10 13:57:48 alexxy Exp $

TEXLIVE_MODULE_CONTENTS="AroBend FAQ-en MemoirChapStyles Type1fonts amslatex-primer compact components-of-TeX comprehensive dtxtut firststeps free-math-font-survey gentle guide-to-latex help impatient knuth l2tabu-english latex2e-help-texinfo latex-course latex-graphics-companion latex-web-companion lshort-english math-into-latex mathmode metafont-for-beginners metafp metapost-examples pdf-forms-tutorial-en pstricks-tutorial tamethebeast tds tex-refs texbytopic tlc2 truetype visualfaq webguide wp-conv xetexref collection-documentation-english
"
TEXLIVE_MODULE_DOC_CONTENTS="AroBend.doc FAQ-en.doc MemoirChapStyles.doc Type1fonts.doc amslatex-primer.doc compact.doc components-of-TeX.doc comprehensive.doc dtxtut.doc firststeps.doc free-math-font-survey.doc gentle.doc guide-to-latex.doc help.doc impatient.doc knuth.doc l2tabu-english.doc latex2e-help-texinfo.doc latex-course.doc latex-graphics-companion.doc latex-web-companion.doc lshort-english.doc math-into-latex.doc mathmode.doc metafont-for-beginners.doc metafp.doc metapost-examples.doc pdf-forms-tutorial-en.doc pstricks-tutorial.doc tamethebeast.doc tds.doc tex-refs.doc texbytopic.doc tlc2.doc truetype.doc visualfaq.doc webguide.doc wp-conv.doc xetexref.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive English documentation"

LICENSE="GPL-2 as-is FDL-1.1 freedist GPL-1 LPPL-1.3 "
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-documentation-base-2008
"
RDEPEND="${DEPEND}"
