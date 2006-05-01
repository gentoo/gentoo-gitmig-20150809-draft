# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-pl/myspell-pl-20060316.ebuild,v 1.1 2006/05/01 16:13:24 kevquinn Exp $

DESCRIPTION="Polish dictionaries for myspell/hunspell"
LICENSE="CCPL-ShareAlike-1.0 LGPL-2.1 GPL-2"
HOMEPAGE="http://lingucomponent.openoffice.org/ http://www.kurnik.pl/dictionary/ http://synonimy.sourceforge.net/"

KEYWORDS="~x86"

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
