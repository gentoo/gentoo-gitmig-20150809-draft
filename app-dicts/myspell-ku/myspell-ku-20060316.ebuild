# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-ku/myspell-ku-20060316.ebuild,v 1.16 2010/05/22 11:19:55 armin76 Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"ku,TR,ku_TR,Kurdish (Turkey),ku_TR.zip"
"ku,TR,ku_TR,Kurdish (Syria),ku_TR.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell

DESCRIPTION="Kurdish dictionaries for myspell/hunspell"
LICENSE="GPL-2"
HOMEPAGE="http://lingucomponent.openoffice.org/ http://www.linux-ku.com/myspell"

KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
