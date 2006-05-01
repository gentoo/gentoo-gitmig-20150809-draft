# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-tn/myspell-tn-20060316.ebuild,v 1.1 2006/05/01 16:18:54 kevquinn Exp $

DESCRIPTION="Setswana dictionaries for myspell/hunspell"
LICENSE="GPL-2"
HOMEPAGE="http://lingucomponent.openoffice.org/"

KEYWORDS="~x86"

MYSPELL_SPELLING_DICTIONARIES=(
"tn,ZA,tn_ZA,Setswana (Africa),tn_ZA.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell
