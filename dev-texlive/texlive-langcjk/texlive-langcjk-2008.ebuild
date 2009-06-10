# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langcjk/texlive-langcjk-2008.ebuild,v 1.12 2009/06/10 14:08:55 alexxy Exp $

TEXLIVE_MODULE_CONTENTS="arphic c90enc cns garuda norasi uhc wadalab yi4latex hyphen-chinese collection-langcjk
"
TEXLIVE_MODULE_DOC_CONTENTS="arphic.doc cns.doc uhc.doc wadalab.doc yi4latex.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive Chinese, Japanese, Korean"

LICENSE="GPL-2 as-is freedist LPPL-1.3 "
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2008
"
RDEPEND="${DEPEND}"
