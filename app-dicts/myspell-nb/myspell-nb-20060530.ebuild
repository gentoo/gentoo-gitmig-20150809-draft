# Copyright 2006-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-nb/myspell-nb-20060530.ebuild,v 1.3 2008/01/06 15:31:08 ranger Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"nb,NO,nb_NO,Norwegian bokmål (Norway),nb_NO.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"nb,NO,hyph_nb_NO,Norwegian bokmål (Norway),hyph_nb_NO.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
"nb,NO,th_nb_NO_v1,Norwegian bokmål (Norway),th_nb_NO_v1.zip"
"nb,NO,th_nb_NO_v2,Norwegian bokmål (Norway),th_nb_NO_v2.zip"
)

inherit myspell

DESCRIPTION="Norwegian dictionaries for myspell/hunspell"
LICENSE="GPL-2"
HOMEPAGE="http://spell-norwegian.alioth.debian.org/"

KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
