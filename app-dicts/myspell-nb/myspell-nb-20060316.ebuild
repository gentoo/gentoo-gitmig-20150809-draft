# Copyright 2006-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-nb/myspell-nb-20060316.ebuild,v 1.10 2008/01/02 12:21:22 armin76 Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"nb,NO,nb_NO,Norwegian Bokmaal (Norway),nb_NO.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell

DESCRIPTION="Norwegian dictionaries for myspell/hunspell"
LICENSE="GPL-2"
HOMEPAGE="http://lingucomponent.openoffice.org/ http://folk.uio.no/runekl/dictionary.html"

KEYWORDS="~alpha amd64 ~ia64 ppc sparc x86 ~x86-fbsd"
