# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-uk/myspell-uk-20060316.ebuild,v 1.18 2012/05/17 18:31:15 aballier Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"uk,UA,uk_UA,Ukrainian (Ukraine),uk_UA.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"uk,UA,hyph_uk_UA,Ukrainian (Ukraine),hyph_uk_UA.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell

DESCRIPTION="Ukrainian dictionaries for myspell/hunspell"
LICENSE="GPL-2"
HOMEPAGE="http://lingucomponent.openoffice.org/"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd"
