# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langcjk/texlive-langcjk-2010.ebuild,v 1.2 2011/08/09 21:17:33 hwoarang Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="adobemapping arphic c90 cjkpunct cns ctex dnp garuda-c90 hyphen-chinese jsclasses norasi-c90 ptex thailatex uhc wadalab zhmetrics zhspacing collection-langcjk
"
TEXLIVE_MODULE_DOC_CONTENTS="arphic.doc c90.doc cjkpunct.doc cns.doc ctex.doc ptex.doc uhc.doc wadalab.doc zhmetrics.doc zhspacing.doc "
TEXLIVE_MODULE_SRC_CONTENTS="c90.source cjkpunct.source garuda-c90.source jsclasses.source norasi-c90.source ptex.source thailatex.source zhmetrics.source "
inherit texlive-module
DESCRIPTION="TeXLive Chinese, Japanese, Korean"

LICENSE="GPL-2 as-is BSD LPPL-1.3 "
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2010
>=app-text/texlive-core-2010[cjk]
"
RDEPEND="${DEPEND} "
