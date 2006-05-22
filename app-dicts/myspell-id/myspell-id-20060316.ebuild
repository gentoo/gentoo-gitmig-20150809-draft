# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-id/myspell-id-20060316.ebuild,v 1.3 2006/05/22 19:00:05 gustavoz Exp $

DESCRIPTION="Indonesian dictionaries for myspell/hunspell"
LICENSE="GPL-2"
HOMEPAGE="http://lingucomponent.openoffice.org/"

KEYWORDS="~amd64 ~sparc ~x86 ~x86-fbsd"

MYSPELL_SPELLING_DICTIONARIES=(
"id,ID,id_ID,Indonesian (Indonesia),id_ID.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"id,ID,hyph_id_ID,Indonesian (Indonesia),hyph_id_ID.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell
