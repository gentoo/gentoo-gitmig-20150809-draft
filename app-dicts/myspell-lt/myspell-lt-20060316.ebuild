# Copyright 2006-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-lt/myspell-lt-20060316.ebuild,v 1.10 2007/12/25 20:52:44 jer Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"lt,LT,lt_LT,Lithuanian (Lithuania),lt_LT.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"lt,LT,hyph_lt_LT,Lithuanian (Lithuania),hyph_lt_LT.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell

DESCRIPTION="Lithuanian dictionaries for myspell/hunspell"
LICENSE="myspell-lt_LT-AlbertasAgejevas LPPL-1.3b"
HOMEPAGE="http://lingucomponent.openoffice.org/ ftp://ftp.akl.lt/ispell-lt/"

KEYWORDS="amd64 ~hppa ppc sparc x86 ~x86-fbsd"
