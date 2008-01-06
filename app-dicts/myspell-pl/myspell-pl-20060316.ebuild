# Copyright 2006-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-pl/myspell-pl-20060316.ebuild,v 1.12 2008/01/06 15:32:08 ranger Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"pl,PL,pl_PL,Polish (Poland),pl_PL.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"pl,PL,hyph_pl_PL,Polish (Poland),hyph_pl_PL.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
"pl,PL,th_pl_PL,Polish (Poland),thes_pl_PL.zip"
)

inherit myspell

DESCRIPTION="Polish dictionaries for myspell/hunspell"
LICENSE="CCPL-ShareAlike-1.0 LGPL-2.1 GPL-2"
HOMEPAGE="http://lingucomponent.openoffice.org/ http://www.kurnik.pl/dictionary/ http://synonimy.sourceforge.net/"

KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ~ppc64 sparc x86 ~x86-fbsd"
