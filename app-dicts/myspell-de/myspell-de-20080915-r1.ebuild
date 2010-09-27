# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-de/myspell-de-20080915-r1.ebuild,v 1.11 2010/09/27 22:44:00 leio Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"de,DE,de_DE_frami,German (Germany),de_DE_frami.zip"
"de,AT,de_AT_frami,German (Austria),de_AT_frami.zip"
"de,CH,de_CH_frami,German (Switzerland),de_CH_frami.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"de,DE,hyph_de_DE,German (Germany),hyph_de_DE.zip"
"de,CH,hyph_de_CH,German (Switzerland),hyph_de_CH.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
"de,DE,th_de_DE_v2,German (Germany),thes_de_DE_v2.zip"
"de,CH,th_de_CH_v2,German (Switzerland),thes_de_CH_v2.zip"
)

inherit myspell

DESCRIPTION="German dictionaries for myspell/hunspell"
LICENSE="GPL-2 LGPL-2"
HOMEPAGE="http://lingucomponent.openoffice.org/"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-macos"
IUSE=""
