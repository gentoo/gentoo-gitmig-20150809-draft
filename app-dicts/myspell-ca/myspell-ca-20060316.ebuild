# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-ca/myspell-ca-20060316.ebuild,v 1.1 2006/05/01 15:54:26 kevquinn Exp $

DESCRIPTION="Catalan dictionaries for myspell/hunspell"
LICENSE="GPL-2"
HOMEPAGE="http://lingucomponent.openoffice.org/"

KEYWORDS="~x86"

MYSPELL_SPELLING_DICTIONARIES=(
"ca,ES,ca_ES,Catalan (Spain),ca_ES.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell
