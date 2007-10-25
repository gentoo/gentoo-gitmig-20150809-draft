# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-polish/texlive-documentation-polish-2007.ebuild,v 1.2 2007/10/25 07:37:43 opfer Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-documentation-base
"
TEXLIVE_MODULE_CONTENTS="guides-pl lshort-polish tex-virtual-academy-pl texlive-pl collection-documentation-polish
"
inherit texlive-module
DESCRIPTION="TeXLive Polish documentation"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="~x86"
