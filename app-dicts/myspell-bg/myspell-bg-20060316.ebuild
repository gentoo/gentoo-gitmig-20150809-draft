# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-bg/myspell-bg-20060316.ebuild,v 1.18 2012/05/17 18:07:39 aballier Exp $

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

DESCRIPTION="Bulgarian dictionaries for myspell/hunspell"
LICENSE="GPL-2"
HOMEPAGE="http://lingucomponent.openoffice.org/ http://bgoffice.sourceforge.net/"

KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""
