# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langcroatian/texlive-langcroatian-2008.ebuild,v 1.11 2009/06/10 14:09:28 alexxy Exp $

TEXLIVE_MODULE_CONTENTS="croatian hrlatex hyphen-croatian collection-langcroatian
"
TEXLIVE_MODULE_DOC_CONTENTS="croatian.doc hrlatex.doc "
TEXLIVE_MODULE_SRC_CONTENTS="hrlatex.source "
inherit texlive-module
DESCRIPTION="TeXLive Croatian"

LICENSE="GPL-2 freedist LPPL-1.3 "
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2008
"
RDEPEND="${DEPEND}"
