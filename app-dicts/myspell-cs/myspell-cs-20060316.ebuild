# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-cs/myspell-cs-20060316.ebuild,v 1.14 2009/06/22 13:29:09 jer Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"cs,CZ,cs_CZ,Czech (Czech Republic),cs_CZ.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"cs,CZ,hyph_cs_CZ,Czech (Czech Republic),hyph_cs_CZ.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
"cs,CZ,th_cs_CZ,Czech (Czech Republic),thes_cs_CZ.zip"
)

inherit myspell

DESCRIPTION="Czech dictionaries for myspell/hunspell"
LICENSE="GPL-2 myspell-th_cs_CZ-PavelRychlySmrz"
HOMEPAGE="http://lingucomponent.openoffice.org/"

KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ppc ~ppc64 ~sh sparc x86 ~x86-fbsd"
