# Copyright 2006-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-zu/myspell-zu-20060316.ebuild,v 1.10 2007/12/25 21:00:54 jer Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"zu,ZA,zu_ZA,Zulu (Africa),zu_ZA.zip"
"zu,ZA,zu_ZA,Zulu (Africa),zu_ZA.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell

DESCRIPTION="Zulu dictionaries for myspell/hunspell"
LICENSE="LGPL-2.1"
HOMEPAGE="http://lingucomponent.openoffice.org/ http://translate.sourceforge.net/"

KEYWORDS="amd64 ~hppa ppc sparc x86 ~x86-fbsd"
