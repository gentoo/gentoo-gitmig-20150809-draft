# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-ru/myspell-ru-20060316.ebuild,v 1.1 2006/05/01 16:15:01 kevquinn Exp $

DESCRIPTION="Russian dictionaries for myspell/hunspell"
LICENSE="LGPL-2.1 myspell-ru_RU-ALexanderLebedev"
HOMEPAGE="http://lingucomponent.openoffice.org/"

KEYWORDS="~x86"

MYSPELL_SPELLING_DICTIONARIES=(
"ru,RU,ru_RU,Russian (Russia),ru_RU.zip"
"ru,RU,ru_RU_ie,Russian_ye (Russia),ru_RU_ye.zip"
"ru,RU,ru_RU_yo,Russian_yo (Russia),ru_RU_yo.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"ru,RU,hyph_ru_RU,Russian (Russia),hyph_ru_RU.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell
