# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-eo/myspell-eo-20060316.ebuild,v 1.8 2006/07/16 07:57:48 tsunam Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"eo,ANY,eo_l3,Esperanto,eo.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell

DESCRIPTION="Esperanto dictionaries for myspell/hunspell"
LICENSE="GPL-2"
HOMEPAGE="http://lingucomponent.openoffice.org/"

KEYWORDS="~amd64 ppc sparc x86 ~x86-fbsd"
