# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langarab/texlive-langarab-2007.ebuild,v 1.2 2007/10/25 07:35:04 opfer Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-basic
"
TEXLIVE_MODULE_CONTENTS="arabi arabtex hyphen-arabic collection-langarab
"
inherit texlive-module
DESCRIPTION="TeXLive Arabic"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="~x86"
