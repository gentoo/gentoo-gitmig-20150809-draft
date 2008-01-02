# Copyright 2006-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-sw/myspell-sw-20060316.ebuild,v 1.11 2008/01/02 12:21:40 armin76 Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"sw,KE,sw_KE,Kiswahili (Africa),sw_KE.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell

DESCRIPTION="Kiswahili dictionaries for myspell/hunspell"
LICENSE="LGPL-2.1"
HOMEPAGE="http://lingucomponent.openoffice.org/"

KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc sparc x86 ~x86-fbsd"
