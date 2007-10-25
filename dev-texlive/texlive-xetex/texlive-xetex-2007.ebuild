# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-xetex/texlive-xetex-2007.ebuild,v 1.2 2007/10/25 08:19:09 opfer Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-basic
"
TEXLIVE_MODULE_CONTENTS="euenc fontspec ifxetex philokalia xetex xetexconfig xetexurl xltxtra xunicode collection-xetex
"
inherit texlive-module
DESCRIPTION="TeXLive XeTeX macros"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="~x86"
