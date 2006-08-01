# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-nn/myspell-nn-20060316.ebuild,v 1.9 2006/08/01 14:34:00 blubb Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"nn,NO,nn_NO,Norwegian Nynorsk (Norway),nn_NO.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell

DESCRIPTION="Norwegian dictionaries for myspell/hunspell"
LICENSE="GPL-2"
HOMEPAGE="http://lingucomponent.openoffice.org/ http://folk.uio.no/runekl/dictionary.html"

KEYWORDS="amd64 ppc sparc x86 ~x86-fbsd"
