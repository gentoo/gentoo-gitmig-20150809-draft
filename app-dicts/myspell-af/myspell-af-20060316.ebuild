# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-af/myspell-af-20060316.ebuild,v 1.19 2012/05/17 18:07:02 aballier Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"af,ZA,af_ZA,Afrikaans (South Africa),af_ZA.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell

DESCRIPTION="Afrikaans dictionaries for myspell/hunspell"
LICENSE="LGPL-2.1"
HOMEPAGE="http://lingucomponent.openoffice.org/ http://translate.org.za/"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""
