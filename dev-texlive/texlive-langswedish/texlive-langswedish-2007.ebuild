# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langswedish/texlive-langswedish-2007.ebuild,v 1.3 2007/10/25 12:45:57 fmccor Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-basic
"
TEXLIVE_MODULE_CONTENTS="hyphen-swedish swebib collection-langswedish
"
inherit texlive-module
DESCRIPTION="TeXLive Swedish"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="~sparc ~x86"
