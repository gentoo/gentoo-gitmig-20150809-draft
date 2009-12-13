# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-hu/myspell-hu-20060531.ebuild,v 1.8 2009/12/13 19:41:39 halcy0n Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"hu,HU,hu_HU_u8,Hungarian (Hungary),hu_HU-1.0.tar.gz"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"hu,HU,hyph_hu,Hungarian (Hungary),huhyphn-20050329.tar.gz"
)

MYSPELL_THESAURUS_DICTIONARIES=(
"hu,HU,th_hu_HU,Hungarian (Hungary),thes_hu_HU.zip"
)

inherit myspell

DESCRIPTION="Hungarian dictionaries for myspell/hunspell"
LICENSE="GPL-2"
HOMEPAGE="http://magyarispell.sourceforge.net/
		http://www.tipogral.hu/index.rbx/site/projects/huhyphn
		http://lingucomponent.openoffice.org/"
SRC_URI="http://magyarispell.sourceforge.net/hu_HU-1.0.tar.gz
		http://www.tipogral.hu/download/huhyphn-20060531.tar.gz
		mirror://gentoo/myspell-thes_hu_HU-20060316.zip"
IUSE=""

KEYWORDS="~alpha amd64 ~ia64 ppc sparc x86 ~x86-fbsd"

src_unpack() {
	unpack ${A}
	mv */* .
}
