# Copyright 2006-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-ga/myspell-ga-20060316.ebuild,v 1.10 2007/12/25 20:48:00 jer Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"ga,IE,ga_IE,Irish (Ireland),ga_IE.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"ga,IE,hyph_ga_IE,Irish (Ireland),hyph_ga_IE.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell

DESCRIPTION="Irish dictionaries for myspell/hunspell"
LICENSE="GPL-2"
HOMEPAGE="http://lingucomponent.openoffice.org/ http://borel.slu.edu/ispell/"

KEYWORDS="amd64 ~hppa ppc sparc x86 ~x86-fbsd"
