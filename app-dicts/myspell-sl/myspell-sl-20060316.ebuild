# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-sl/myspell-sl-20060316.ebuild,v 1.14 2009/06/22 13:45:22 jer Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"sl,SI,sl_SI,Slovenian (Slovenia),sl_SI.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"sl,SI,hyph_sl_SI,Slovenian (Slovenia),hyph_sl_SI.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell

DESCRIPTION="Slovenian dictionaries for myspell/hunspell"
LICENSE="GPL-2"
HOMEPAGE="http://lingucomponent.openoffice.org/"

KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ppc ~ppc64 ~sh sparc x86 ~x86-fbsd"
