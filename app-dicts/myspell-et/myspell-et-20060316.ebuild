# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-et/myspell-et-20060316.ebuild,v 1.19 2012/05/17 18:14:09 aballier Exp $

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

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd"
