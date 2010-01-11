# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langcjk/texlive-langcjk-2009.ebuild,v 1.1 2010/01/11 03:20:00 aballier Exp $

TEXLIVE_MODULE_CONTENTS="arphic c90 cjkpunct cns ctex dnp garuda-c90 hyphen-chinese norasi-c90 thailatex uhc wadalab zhmetrics zhspacing collection-langcjk
"
TEXLIVE_MODULE_DOC_CONTENTS="arphic.doc c90.doc cjkpunct.doc cns.doc ctex.doc uhc.doc wadalab.doc zhmetrics.doc zhspacing.doc "
TEXLIVE_MODULE_SRC_CONTENTS="c90.source cjkpunct.source garuda-c90.source norasi-c90.source thailatex.source zhmetrics.source "
inherit texlive-module
DESCRIPTION="TeXLive Chinese, Japanese, Korean"

LICENSE="GPL-2 as-is freedist LPPL-1.3 "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2009
>=dev-texlive/texlive-documentation-chinese-2009
"
RDEPEND="${DEPEND} "
