# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-it/myspell-it-20081129.ebuild,v 1.2 2012/05/17 18:19:58 aballier Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"it,IT,it_IT,Italian (Italy),it_IT.zip"
"it,CH,it_IT,Italian (Switzerland),it_IT.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"it,IT,hyph_it_IT,Italian (Italy),hyph_it_IT.zip"
"it,CH,hyph_it_IT,Italian (Switzerland),hyph_it_IT.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
"it,IT,th_it_IT,Italian (Italy),thes_it_IT.zip"
"it,CH,th_it_IT,Italian (Switzerland),thes_it_IT.zip"
)

inherit myspell

DESCRIPTION="Italian dictionaries for myspell/hunspell"
LICENSE="AGPL-3 GPL-3 LPPL-1.3c"
HOMEPAGE="http://sourceforge.net/projects/linguistico/"

MY_PV=01_07__2008_11_29
SRC_URI="mirror://sourceforge/linguistico/it_IT-OOo2-pack_${MY_PV}.zip"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE=

src_unpack() {
	unpack ${A}
	unpack ./{,hyph_,thes_}it_IT.zip
}
