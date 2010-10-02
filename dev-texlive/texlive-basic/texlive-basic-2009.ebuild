# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-basic/texlive-basic-2009.ebuild,v 1.4 2010/10/02 19:47:27 grobian Exp $

TEXLIVE_MODULE_CONTENTS="amsfonts apalike bibtex cm dvipdfmx-def enctex etex etex-pkg glyphlist hyph-utf8 ifluatex ifxetex luatex makeindex metafont mflogo mfware misc pdftex plain tcdialog tex texlive-msg-translations texlive-scripts collection-basic
"
TEXLIVE_MODULE_DOC_CONTENTS="amsfonts.doc apalike.doc bibtex.doc cm.doc enctex.doc etex.doc etex-pkg.doc hyph-utf8.doc ifluatex.doc ifxetex.doc luatex.doc makeindex.doc metafont.doc mflogo.doc mfware.doc pdftex.doc tcdialog.doc tex.doc texlive-scripts.doc "
TEXLIVE_MODULE_SRC_CONTENTS="amsfonts.source hyph-utf8.source ifluatex.source ifxetex.source mflogo.source "
inherit texlive-module
DESCRIPTION="TeXLive Essential programs and files"

LICENSE="GPL-2 as-is GPL-1 LPPL-1.3 OFL public-domain TeX "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-documentation-base-2009
>=dev-tex/luatex-0.45
!<app-text/texlive-core-2009
!<dev-texlive/texlive-latex-2009
!<dev-texlive/texlive-latexrecommended-2009
"
RDEPEND="${DEPEND} "
TEXLIVE_MODULE_BINSCRIPTS="texmf/scripts/simpdftex/simpdftex texmf/scripts/texlive/rungs.tlu texmf/scripts/texlive/tlmgr.pl"
