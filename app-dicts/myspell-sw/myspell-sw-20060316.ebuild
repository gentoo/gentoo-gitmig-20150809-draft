# Copyright 2006-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-sw/myspell-sw-20060316.ebuild,v 1.10 2007/12/25 20:59:33 jer Exp $

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

KEYWORDS="amd64 ~hppa ppc sparc x86 ~x86-fbsd"
