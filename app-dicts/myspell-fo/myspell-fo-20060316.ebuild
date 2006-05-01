# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-fo/myspell-fo-20060316.ebuild,v 1.1 2006/05/01 15:59:53 kevquinn Exp $

DESCRIPTION="Faroese dictionaries for myspell/hunspell"
LICENSE="GPL-2"
HOMEPAGE="http://lingucomponent.openoffice.org/ http://fo.speling.org/"

KEYWORDS="~x86"

MYSPELL_SPELLING_DICTIONARIES=(
"fo,FO,fo_FO,Faroese (Faroe Islands),fo_FO.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell
