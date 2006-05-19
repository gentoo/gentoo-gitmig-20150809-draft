# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-el/myspell-el-20060316.ebuild,v 1.2 2006/05/19 21:01:34 flameeyes Exp $

DESCRIPTION="Greek dictionaries for myspell/hunspell"
LICENSE="GPL-2 LGPL-2.1"
HOMEPAGE="http://lingucomponent.openoffice.org/ http://ispell.source.gr http://interzone.gr"

KEYWORDS="~amd64 ~x86 ~x86-fbsd"

MYSPELL_SPELLING_DICTIONARIES=(
"el,GR,el_GR,Greek (Greece),el_GR.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"el,GR,hyph_el_GR,Greek (Greece),hyph_el_GR.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell
