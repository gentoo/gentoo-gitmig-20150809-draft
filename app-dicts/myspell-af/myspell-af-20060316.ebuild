# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-af/myspell-af-20060316.ebuild,v 1.7 2006/07/09 01:00:45 kevquinn Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"af,ZA,af_ZA,Afrikaans (South Africa),af_ZA.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell

DESCRIPTION="Afrikaans dictionaries for myspell/hunspell"
LICENSE="LGPL-2.1"
HOMEPAGE="http://lingucomponent.openoffice.org/ http://translate.org.za/"

KEYWORDS="~amd64 ppc sparc ~x86 ~x86-fbsd"
