# Copyright 2006-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-mi/myspell-mi-20060316.ebuild,v 1.12 2008/01/06 15:29:56 ranger Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"mi,NZ,mi_NZ,Maori (New Zealand),mi_NZ.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell

DESCRIPTION="Maori dictionaries for myspell/hunspell"
LICENSE="LGPL-2.1"
HOMEPAGE="http://lingucomponent.openoffice.org/"

KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ~ppc64 sparc x86 ~x86-fbsd"
