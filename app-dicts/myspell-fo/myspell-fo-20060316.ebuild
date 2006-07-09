# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-fo/myspell-fo-20060316.ebuild,v 1.7 2006/07/09 01:07:16 kevquinn Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"fo,FO,fo_FO,Faroese (Faroe Islands),fo_FO.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell

DESCRIPTION="Faroese dictionaries for myspell/hunspell"
LICENSE="GPL-2"
HOMEPAGE="http://lingucomponent.openoffice.org/ http://fo.speling.org/"

KEYWORDS="~amd64 ppc sparc ~x86 ~x86-fbsd"
