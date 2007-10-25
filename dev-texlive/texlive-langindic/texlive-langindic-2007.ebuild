# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langindic/texlive-langindic-2007.ebuild,v 1.2 2007/10/25 08:03:13 opfer Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-basic
"
TEXLIVE_MODULE_CONTENTS="bangtex bengali bin-devnag bin-ebong burmese ebong itrans malayalam omega-devanagari sanskrit velthuis wnri wntamil collection-langindic
"
inherit texlive-module
DESCRIPTION="TeXLive Indic"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="~x86"
