# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-fo/myspell-fo-20060316.ebuild,v 1.16 2010/05/13 19:30:09 josejx Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"fo,FO,fo_FO,Faroese (Faroe Islands),fo_FO.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell

DESCRIPTION="Faroese dictionaries for myspell/hunspell"
LICENSE="GPL-2"
HOMEPAGE="http://lingucomponent.openoffice.org/ http://fo.speling.org/"
IUSE=""

KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ppc ppc64 ~sh sparc x86 ~x86-fbsd"
