# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-nn/myspell-nn-20060316.ebuild,v 1.1 2006/05/01 16:12:31 kevquinn Exp $

DESCRIPTION="Norwegian dictionaries for myspell/hunspell"
LICENSE="GPL-2"
HOMEPAGE="http://lingucomponent.openoffice.org/ http://folk.uio.no/runekl/dictionary.html"

KEYWORDS="~x86"

MYSPELL_SPELLING_DICTIONARIES=(
"nn,NO,nn_NO,Norwegian Nynorsk (Norway),nn_NO.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell
