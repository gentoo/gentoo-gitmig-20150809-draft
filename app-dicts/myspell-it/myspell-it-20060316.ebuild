# Copyright 2006-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-it/myspell-it-20060316.ebuild,v 1.11 2007/12/25 20:51:46 jer Exp $

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

DESCRIPTION="Italian dictionaries for myspell/hunspell"
LICENSE="GPL-2 LPPL-1.3b"
HOMEPAGE="http://lingucomponent.openoffice.org/ http://sourceforge.net/projects/linguistico/"

KEYWORDS="amd64 ~hppa ppc sparc x86 ~x86-fbsd"
