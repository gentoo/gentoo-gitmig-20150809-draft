# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langlithuanian/texlive-langlithuanian-2009.ebuild,v 1.10 2010/06/01 14:35:52 josejx Exp $

TEXLIVE_MODULE_CONTENTS="lithuanian hyphen-lithuanian collection-langlithuanian
"
TEXLIVE_MODULE_DOC_CONTENTS="lithuanian.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive Lithuanian"

LICENSE="GPL-2 LPPL-1.3 "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2009
"
RDEPEND="${DEPEND} "
