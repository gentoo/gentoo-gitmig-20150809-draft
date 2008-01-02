# Copyright 2006-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-ia/myspell-ia-20060316.ebuild,v 1.11 2008/01/02 12:21:21 armin76 Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"ia,ANY,ia,Interlingua (ANY locale),ia_ANY.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"ia,ANY,hyph_ia,Interlingua (ANY locale),hyph_ia_ANY.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell

DESCRIPTION="Interlingua dictionaries for myspell/hunspell"
LICENSE="LGPL-2.1"
HOMEPAGE="http://lingucomponent.openoffice.org/"

KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc sparc x86 ~x86-fbsd"
