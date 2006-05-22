# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-sv/myspell-sv-20060316.ebuild,v 1.3 2006/05/22 19:17:04 gustavoz Exp $

DESCRIPTION="Swedish dictionaries for myspell/hunspell"
LICENSE="LGPL-2.1"
HOMEPAGE="http://lingucomponent.openoffice.org/ http://sv.speling.org/"

KEYWORDS="~amd64 ~sparc ~x86 ~x86-fbsd"

MYSPELL_SPELLING_DICTIONARIES=(
"sv,SE,sv_SE,Swedish (Sweden),sv_SE.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"sv,SE,hyph_sv_SE,Swedish(Sweden),hyph_sv_SE.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell
