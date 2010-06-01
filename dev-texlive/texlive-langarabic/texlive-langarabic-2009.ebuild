# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langarabic/texlive-langarabic-2009.ebuild,v 1.10 2010/06/01 14:35:16 josejx Exp $

TEXLIVE_MODULE_CONTENTS="arabi arabtex hyphen-arabic hyphen-farsi collection-langarabic
"
TEXLIVE_MODULE_DOC_CONTENTS="arabi.doc arabtex.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive Arabic"

LICENSE="GPL-2 LPPL-1.3 "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2009
!dev-texlive/texlive-langarab
"
RDEPEND="${DEPEND} "
