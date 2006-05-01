# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-et/myspell-et-20060316.ebuild,v 1.1 2006/05/01 15:59:24 kevquinn Exp $

DESCRIPTION="Estonian dictionaries for myspell/hunspell"
LICENSE="LGPL-2.1 myspell-et_EE-IEL"
HOMEPAGE="http://lingucomponent.openoffice.org/ http://www.meso.ee/~jjpp/speller/"

KEYWORDS="~x86"

MYSPELL_SPELLING_DICTIONARIES=(
"et,EE,et_EE,Estonian (Estonia),et_EE.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"et,EE,hyph_et_EE,Estonian (Estonia),hyph_et_EE.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell
