# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-et/myspell-et-20060316.ebuild,v 1.15 2009/12/13 19:33:07 halcy0n Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"et,EE,et_EE,Estonian (Estonia),et_EE.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"et,EE,hyph_et_EE,Estonian (Estonia),hyph_et_EE.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell

DESCRIPTION="Estonian dictionaries for myspell/hunspell"
LICENSE="LGPL-2.1 myspell-et_EE-IEL"
HOMEPAGE="http://lingucomponent.openoffice.org/ http://www.meso.ee/~jjpp/speller/"
IUSE=""

KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ppc ~ppc64 ~sh sparc x86 ~x86-fbsd"
