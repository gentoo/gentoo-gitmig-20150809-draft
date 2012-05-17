# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-nl/myspell-nl-20060316.ebuild,v 1.11 2012/05/17 18:24:46 aballier Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"nl,NL,nl_NL,Dutch (Netherlands),nl_NL.zip"
"nl,NL,nl_med,Dutch (medical),nl_med.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"nl,NL,hyph_nl_NL,Dutch (Netherlands), hyph_nl_NL.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell

DESCRIPTION="Dutch dictionaries for myspell/hunspell"
LICENSE="GPL-2"
HOMEPAGE="http://lingucomponent.openoffice.org/ http://www.goddijn.com/words.htm"

KEYWORDS="alpha amd64 arm ia64 ppc sh sparc x86 ~amd64-fbsd ~x86-fbsd"
