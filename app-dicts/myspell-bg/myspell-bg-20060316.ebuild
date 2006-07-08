# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-bg/myspell-bg-20060316.ebuild,v 1.6 2006/07/08 23:42:41 pylon Exp $

DESCRIPTION="Bulgarian dictionaries for myspell/hunspell"
LICENSE="GPL-2"
HOMEPAGE="http://lingucomponent.openoffice.org/ http://bgoffice.sourceforge.net/"

KEYWORDS="~amd64 ppc sparc ~x86 ~x86-fbsd"

MYSPELL_SPELLING_DICTIONARIES=(
"bg,BG,bg_BG,Bulgarian (Bulgaria),bg_BG.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"bg,BG,hyph_bg_BG,Bulgarian (Bulgaria),hyph_bg_BG.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
"bg,BG,th_bg_BG,Bulgarian (Bulgaria),thes_bg_BG.zip"
)

inherit myspell
