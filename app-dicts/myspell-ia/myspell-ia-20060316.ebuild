# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-ia/myspell-ia-20060316.ebuild,v 1.4 2006/06/04 11:00:41 kevquinn Exp $

DESCRIPTION="Interlingua dictionaries for myspell/hunspell"
LICENSE="LGPL-2.1"
HOMEPAGE="http://lingucomponent.openoffice.org/"

KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"

MYSPELL_SPELLING_DICTIONARIES=(
"ia,ANY,ia,Interlingua (ANY locale),ia_ANY.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"ia,ANY,hyph_ia,Interlingua (ANY locale),hyph_ia_ANY.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell
