# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langindic/texlive-langindic-2008-r1.ebuild,v 1.10 2009/06/10 14:13:32 alexxy Exp $

TEXLIVE_MODULE_CONTENTS="bangtex bengali burmese ebong hyphen-sanskrit itrans malayalam omega-devanagari sanskrit velthuis wnri bin-devnag bin-ebong collection-langindic
"
TEXLIVE_MODULE_DOC_CONTENTS="bangtex.doc burmese.doc ebong.doc itrans.doc malayalam.doc omega-devanagari.doc sanskrit.doc velthuis.doc wnri.doc "
TEXLIVE_MODULE_SRC_CONTENTS="bengali.source burmese.source malayalam.source sanskrit.source wnri.source "
inherit texlive-module
DESCRIPTION="TeXLive Indic scripts"

LICENSE="GPL-2 GPL-1 LPPL-1.3 "
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2008
"
RDEPEND="${DEPEND} "
TEXLIVE_MODULE_BINSCRIPTS="texmf-dist/scripts/bengali/ebong.py"
