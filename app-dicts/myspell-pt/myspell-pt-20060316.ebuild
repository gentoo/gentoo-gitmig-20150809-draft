# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-pt/myspell-pt-20060316.ebuild,v 1.17 2010/09/27 23:41:00 leio Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"pt,BR,pt_BR,Portuguese (Brazil),pt_BR.zip"
"pt,PT,pt_PT,Portuguese (Portugal),pt_PT.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"pt,BR,hyph_pt_BR,Portuguese (Brazil),hyph_pt_BR.zip"
"pt,PT,hyph_pt_PT,Portuguese (Portugal),hyph_pt_PT.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell

DESCRIPTION="Portuguese dictionaries for myspell/hunspell"
LICENSE="GPL-2"
HOMEPAGE="http://lingucomponent.openoffice.org/"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd"
