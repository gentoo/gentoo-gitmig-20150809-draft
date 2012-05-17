# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-lt/myspell-lt-20060316.ebuild,v 1.20 2012/05/17 18:21:11 aballier Exp $

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
LICENSE="BSD LPPL-1.3b"
HOMEPAGE="http://lingucomponent.openoffice.org/ ftp://ftp.akl.lt/ispell-lt/"
IUSE=""

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd"
