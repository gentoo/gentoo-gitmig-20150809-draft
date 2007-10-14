# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-italian/texlive-documentation-italian-2007.ebuild,v 1.1 2007/10/14 10:17:48 aballier Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-documentation-base
"
TEXLIVE_MODULE_CONTENTS="amsldoc-it amsmath-it amsthdoc-it fancyhdr-it l2tabu-it lshort-italian collection-documentation-italian
"
inherit texlive-module
DESCRIPTION="TeXLive Italian documentation"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS=""
