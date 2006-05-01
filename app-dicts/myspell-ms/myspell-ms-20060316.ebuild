# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-ms/myspell-ms-20060316.ebuild,v 1.1 2006/05/01 16:10:37 kevquinn Exp $

DESCRIPTION="Malay dictionaries for myspell/hunspell"
LICENSE="FDL-1.2"
HOMEPAGE="http://lingucomponent.openoffice.org/"

KEYWORDS="~x86"

MYSPELL_SPELLING_DICTIONARIES=(
"ms,MY,ms_MY,Malay (Malaysia),ms_MY.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell
