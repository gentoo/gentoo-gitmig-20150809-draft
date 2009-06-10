# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-context/texlive-context-2008-r1.ebuild,v 1.10 2009/06/10 13:55:28 alexxy Exp $

TEXLIVE_MODULE_CONTENTS="context jmn lmextra bin-context context-account context-bnf context-chromato context-construction-plan context-degrade context-french context-letter context-lettrine context-lilypond context-mathsets context-taspresent context-typearea context-vim collection-context
"
TEXLIVE_MODULE_DOC_CONTENTS="context.doc bin-context.doc context-account.doc context-bnf.doc context-chromato.doc context-construction-plan.doc context-degrade.doc context-french.doc context-letter.doc context-lettrine.doc context-lilypond.doc context-mathsets.doc context-taspresent.doc context-typearea.doc context-vim.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive ConTeXt format"

LICENSE="GPL-2 as-is freedist GPL-1 GPL-2 public-domain "
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-metapost-2008
>=dev-texlive/texlive-basic-2008
>=dev-texlive/texlive-latex-2008
"
RDEPEND="${DEPEND} dev-lang/ruby
"
TL_CONTEXT_UNIX_STUBS="context ctxtools exatools luatools makempy mpstools mptopdf mtxrun mtxtools pdftools pdftrimwhite pstopdf rlxtools runtools texexec texfind texfont texshow textools texutil tmftools xmltools"
TEXLIVE_MODULE_BINSCRIPTS="texmf-dist/scripts/context/ruby/texmfstart.rb"
for i in ${TL_CONTEXT_UNIX_STUBS} ; do
TEXLIVE_MODULE_BINSCRIPTS="${TEXLIVE_MODULE_BINSCRIPTS} texmf-dist/scripts/context/stubs/unix/$i"
done
