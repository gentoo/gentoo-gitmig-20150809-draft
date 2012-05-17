# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-hu/myspell-hu-20061117.ebuild,v 1.7 2012/05/17 18:18:13 aballier Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"hu,HU,hu_HU_u8,Hungarian UTF-8 (Hungary),hu_HU-1.1.1.tar.gz"
"hu,HU,hu_HU,Hungarian (Hungary),hu_HU-1.1.1.tar.gz"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"hu,HU,hyph_hu,Hungarian (Hungary),huhyphn-20060712.tar.gz"
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
SRC_URI="http://magyarispell.sourceforge.net/hu_HU-1.1.1.tar.gz
		http://www.tipogral.hu/download/huhyphn-20060713.tar.gz
		mirror://gentoo/myspell-thes_hu_HU-20060316.zip"
IUSE=""

KEYWORDS="alpha ~amd64 arm ~hppa ia64 ~ppc ~ppc64 sh sparc ~x86 ~amd64-fbsd ~x86-fbsd"

src_unpack() {
	unpack ${A}
	mv */* .
}
