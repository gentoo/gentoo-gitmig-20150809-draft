# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-mk/myspell-mk-20060316.ebuild,v 1.4 2006/06/04 11:06:16 kevquinn Exp $

DESCRIPTION="Macedonian dictionaries for myspell/hunspell"
LICENSE="GPL-2"
HOMEPAGE="http://lingucomponent.openoffice.org/"

KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"

MYSPELL_SPELLING_DICTIONARIES=(
"mk,MK,mk_MK,Macedonian (Macedonia),mk_MK.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell
