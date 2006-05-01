# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-he/myspell-he-20060316.ebuild,v 1.1 2006/05/01 16:01:56 kevquinn Exp $

DESCRIPTION="Hebrew dictionaries for myspell/hunspell"
LICENSE="GPL-2"
HOMEPAGE="http://lingucomponent.openoffice.org/ http://ivrix.org.il/projects/spell-checker/"

KEYWORDS="~x86"

MYSPELL_SPELLING_DICTIONARIES=(
"he,IL,he_IL,Hebrew (Israel),he_IL.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell
