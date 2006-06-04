# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-ms/myspell-ms-20060316.ebuild,v 1.4 2006/06/04 11:06:48 kevquinn Exp $

DESCRIPTION="Malay dictionaries for myspell/hunspell"
LICENSE="FDL-1.2"
HOMEPAGE="http://lingucomponent.openoffice.org/"

KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"

MYSPELL_SPELLING_DICTIONARIES=(
"ms,MY,ms_MY,Malay (Malaysia),ms_MY.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell
