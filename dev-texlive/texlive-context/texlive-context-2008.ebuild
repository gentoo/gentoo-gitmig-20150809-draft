# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-context/texlive-context-2008.ebuild,v 1.1 2008/09/09 16:13:36 aballier Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-metapost
dev-texlive/texlive-basic
dev-texlive/texlive-latex
"
TEXLIVE_MODULE_CONTENTS="context jmn lmextra bin-context context-account context-bnf context-chromato context-construction-plan context-degrade context-french context-letter context-lettrine context-lilypond context-mathsets context-taspresent context-typearea context-vim collection-context
"
TEXLIVE_MODULE_DOC_CONTENTS="context.doc bin-context.doc context-account.doc context-bnf.doc context-chromato.doc context-construction-plan.doc context-degrade.doc context-french.doc context-letter.doc context-lettrine.doc context-lilypond.doc context-mathsets.doc context-taspresent.doc context-typearea.doc context-vim.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive ConTeXt format"

LICENSE="GPL-2 as-is freedist GPL-1 GPL-2 public-domain "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
TL_CONTEXT_UNIX_STUBS="context ctxtools exatools luatools makempy mpstools mptopdf mtxrun mtxtools pdftools pdftrimwhite pstopdf rlxtools runtools texexec texfind texfont texshow textools texutil tmftools xmltools"
TEXLIVE_MODULE_BINSCRIPTS="texmf-dist/scripts/context/ruby/texmfstart.rb"
for i in ${TL_CONTEXT_UNIX_STUBS} ; do
TEXLIVE_MODULE_BINSCRIPTS="${TEXLIVE_MODULE_BINSCRIPTS} texmf-dist/scripts/context/stubs/unix/$i"
done
