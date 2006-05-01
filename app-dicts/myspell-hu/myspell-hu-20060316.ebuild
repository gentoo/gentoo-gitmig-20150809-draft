# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-hu/myspell-hu-20060316.ebuild,v 1.1 2006/05/01 16:03:18 kevquinn Exp $

DESCRIPTION="Hungarian dictionaries for myspell/hunspell"
LICENSE="GPL-2"
HOMEPAGE="http://lingucomponent.openoffice.org/ http://huhypn.tipogral.hu/"

KEYWORDS="~x86"

MYSPELL_SPELLING_DICTIONARIES=(
"hu,HU,hu_HU,Hungarian (Hungary),hu_HU.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"hu,HU,hyph_hu_HU,Hungarian (Hungary),hyph_hu_HU.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
"hu,HU,th_hu_HU,Hungarian (Hungary),thes_hu_HU.zip"
)

inherit myspell
