# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-context/texlive-context-2009.ebuild,v 1.2 2010/01/14 08:47:02 aballier Exp $

TEXLIVE_MODULE_CONTENTS="context jmn lmextra context-account context-algorithmic context-bnf context-chromato context-construction-plan context-degrade context-fixme context-french context-games context-gnuplot context-letter context-lettrine context-lilypond context-mathsets context-notes-zh-cn context-simplefonts context-simpleslides context-top-ten context-typearea context-typescripts context-vim collection-context
"
TEXLIVE_MODULE_DOC_CONTENTS="context.doc context-account.doc context-bnf.doc context-chromato.doc context-construction-plan.doc context-degrade.doc context-fixme.doc context-french.doc context-games.doc context-letter.doc context-lettrine.doc context-lilypond.doc context-mathsets.doc context-notes-zh-cn.doc context-simplefonts.doc context-simpleslides.doc context-top-ten.doc context-typearea.doc context-typescripts.doc context-vim.doc "
TEXLIVE_MODULE_SRC_CONTENTS="context-fixme.source context-letter.source context-simplefonts.source "
inherit texlive-module
DESCRIPTION="TeXLive ConTeXt format"

LICENSE="GPL-2 as-is FDL-1.1 freedist GPL-1 GPL-2 public-domain "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-metapost-2009
>=dev-texlive/texlive-basic-2009
>=dev-texlive/texlive-latex-2008
"
RDEPEND="${DEPEND} dev-lang/ruby
"
TL_CONTEXT_UNIX_STUBS="context ctxtools makempy mpstools mptopdf mtxtools pdftools pstopdf rlxtools runtools texexec texfont textools texutil tmftools xmltools"
TEXLIVE_MODULE_BINSCRIPTS="texmf-dist/scripts/context/lua/luatools.lua texmf-dist/scripts/context/lua/mtxrun.lua texmf-dist/scripts/context/ruby/texmfstart.rb"
for i in ${TL_CONTEXT_UNIX_STUBS} ; do
TEXLIVE_MODULE_BINSCRIPTS="${TEXLIVE_MODULE_BINSCRIPTS} texmf-dist/scripts/context/stubs/unix/$i"
done

# This small hack is needed in order to have a sane upgrade path:
# the new TeX Live 2009 metapost produces this file but it is not recorded in
# any package; when running fmtutil (like texmf-update does) this file will be
# created and cause collisions.

pkg_setup() {
	if [ -f "${ROOT}/var/lib/texmf/web2c/metapost/metafun.log" ]; then
		einfo "Removing ${ROOT}/var/lib/texmf/web2c/metapost/metafun.log"
		rm -f "${ROOT}/var/lib/texmf/web2c/metapost/metafun.log"
	fi
}
