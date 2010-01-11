# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-english/texlive-documentation-english-2009.ebuild,v 1.1 2010/01/11 03:08:48 aballier Exp $

TEXLIVE_MODULE_CONTENTS="FAQ-en MemoirChapStyles Type1fonts amslatex-primer around-the-bend asciichart components-of-TeX comprehensive dtxtut first-latex-doc firststeps free-math-font-survey gentle guide-to-latex impatient intro-scientific knuth l2tabu-english latex2e-help-texinfo latex-course latex-doc-ptr latex-graphics-companion latex-veryshortguide latex-web-companion latexcheat lshort-english math-into-latex mathmode memdesign metafont-beginners metapost-examples patgen2-tutorial pdf-forms-tutorial-en plain-doc pstricks-tutorial tamethebeast tds tex-refs texbytopic titlepages tlc2 visualfaq webguide xetexref collection-documentation-english
"
TEXLIVE_MODULE_DOC_CONTENTS="FAQ-en.doc MemoirChapStyles.doc Type1fonts.doc amslatex-primer.doc around-the-bend.doc asciichart.doc components-of-TeX.doc comprehensive.doc dtxtut.doc first-latex-doc.doc firststeps.doc free-math-font-survey.doc gentle.doc guide-to-latex.doc impatient.doc intro-scientific.doc knuth.doc l2tabu-english.doc latex2e-help-texinfo.doc latex-course.doc latex-doc-ptr.doc latex-graphics-companion.doc latex-veryshortguide.doc latex-web-companion.doc latexcheat.doc lshort-english.doc math-into-latex.doc mathmode.doc memdesign.doc metafont-beginners.doc metapost-examples.doc patgen2-tutorial.doc pdf-forms-tutorial-en.doc plain-doc.doc pstricks-tutorial.doc tamethebeast.doc tds.doc tex-refs.doc texbytopic.doc titlepages.doc tlc2.doc visualfaq.doc webguide.doc xetexref.doc "
TEXLIVE_MODULE_SRC_CONTENTS="knuth.source "
inherit texlive-module
DESCRIPTION="TeXLive English documentation"

LICENSE="GPL-2 as-is FDL-1.1 freedist GPL-1 LPPL-1.3 public-domain TeX "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-documentation-base-2009
"
RDEPEND="${DEPEND} "
