# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-de/myspell-de-20060316.ebuild,v 1.1 2006/05/01 15:56:24 kevquinn Exp $

DESCRIPTION="German dictionaries for myspell/hunspell"
LICENSE="GPL-2"
HOMEPAGE="http://lingucomponent.openoffice.org/"

KEYWORDS="~x86"

MYSPELL_SPELLING_DICTIONARIES=(
"de,AT,de_DE,German (Austria Base),de_DE.zip"
"de,AT,de_AT,German (Austria Extension),de_AT.zip"
"de,DE,de_DE,German (Germany),de_DE.zip"
"de,DE,de_DE_neu,German (Germany-neu ortho.),de_DE_neu.zip"
"de,DE,de_DE_comb,German (Germany-comb ortho.),de_DE_comb.zip"
"de,LI,de_CH,German (Liechtenstein),de_CH.zip"
"de,LU,de_DE,German (Luxembourg),de_DE.zip"
"de,CH,de_CH,German (Switzerland),de_CH.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"de,AT,hyph_de_DE,German (Austria),hyph_de_DE.zip"
"de,DE,hyph_de_DE,German (Germany),hyph_de_DE.zip"
"de,LI,hyph_de_DE,German (Liechtenstein),hyph_de_DE.zip"
"de,LU,hyph_de_DE,German (Luxembourg),hyph_de_DE.zip"
"de,CH,hyph_de_CH,German (Switzerland),hyph_de_CH.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
"de,AT,th_de_DE,German (Austria),thes_de_DE.zip"
"de,DE,th_de_DE,German (Germany),thes_de_DE.zip"
"de,LI,th_de_DE,German (Liechtenstein),thes_de_DE.zip"
"de,LU,th_de_DE,German (Luxembourg),thes_de_DE.zip"
"de,CH,th_de_DE,German (Switzerland),thes_de_DE.zip"
)

inherit myspell
