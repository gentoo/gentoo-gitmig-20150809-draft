# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-thai/texlive-documentation-thai-2007.ebuild,v 1.3 2007/10/25 12:46:22 fmccor Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-documentation-base
"
TEXLIVE_MODULE_CONTENTS="lshort-thai collection-documentation-thai
"
inherit texlive-module
DESCRIPTION="TeXLive Thai documentation"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="~sparc ~x86"
