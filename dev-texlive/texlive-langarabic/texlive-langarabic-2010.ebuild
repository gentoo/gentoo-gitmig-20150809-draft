# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langarabic/texlive-langarabic-2010.ebuild,v 1.7 2011/10/04 18:05:44 jer Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="arabi arabtex bidi hyphen-arabic hyphen-farsi persian-bib collection-langarabic
"
TEXLIVE_MODULE_DOC_CONTENTS="arabi.doc arabtex.doc bidi.doc persian-bib.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive Arabic"

LICENSE="GPL-2 LPPL-1.3 "
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2010
!dev-texlive/texlive-langarab
!<dev-texlive/texlive-xetex-2010
"
RDEPEND="${DEPEND} "
