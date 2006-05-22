# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-it/myspell-it-20060316.ebuild,v 1.4 2006/05/22 19:01:07 gustavoz Exp $

DESCRIPTION="Italian dictionaries for myspell/hunspell"
LICENSE="GPL-2 LPPL-1.3b"
HOMEPAGE="http://lingucomponent.openoffice.org/ http://sourceforge.net/projects/linguistico/"

KEYWORDS="~amd64 ~sparc ~x86 ~x86-fbsd"

MYSPELL_SPELLING_DICTIONARIES=(
"it,IT,it_IT,Italian (Italy),it_IT.zip"
"it,CH,it_IT,Italian (Switzerland),it_IT.zip"
"it,IT,la,Latin (for x-register),la.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"it,IT,hyph_it_IT,Italian (Italy),hyph_it_IT.zip"
"it,CH,hyph_it_IT,Italian (Switzerland),hyph_it_IT.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell
