# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-uk/myspell-uk-20060316.ebuild,v 1.6 2006/07/08 23:42:41 pylon Exp $

DESCRIPTION="Ukrainian dictionaries for myspell/hunspell"
LICENSE="GPL-2"
HOMEPAGE="http://lingucomponent.openoffice.org/"

KEYWORDS="~amd64 ppc sparc ~x86 ~x86-fbsd"

MYSPELL_SPELLING_DICTIONARIES=(
"uk,UA,uk_UA,Ukrainian (Ukraine),uk_UA.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"uk,UA,hyph_uk_UA,Ukrainian (Ukraine),hyph_uk_UA.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell
