# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-de-alt/myspell-de-alt-20060124.ebuild,v 1.7 2009/05/14 21:06:34 tcunha Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"de,DE,de_DE_1901,German (traditional orthography),de_DE_1901.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"de,DE,hyph_de_DE_1901,German (traditional orthography),hyph_de_DE_1901.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell

DESCRIPTION="German dictionaries (traditional orthography) for myspell/hunspell"
HOMEPAGE="http://www.j3e.de/myspell/"

LICENSE="GPL-2"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh sparc x86"
IUSE=""

# override myspell.eclass function, to avoid file collision
# for "dictionary.lst.$(get_myspell_lang)" with app-dicts/myspell-de
get_myspell_lang() {
	echo de_1901
}

src_unpack() {
	unpack ${A}
	# see http://www.iana.org/assignments/language-subtag-registry
	mv de_OLDSPELL.aff de_DE_1901.aff || die
	mv de_OLDSPELL.dic de_DE_1901.dic || die
	mv hyph_de_OLD.dic hyph_de_DE_1901.dic || die
}
