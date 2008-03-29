# Copyright 2006-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-hu/myspell-hu-20080315.ebuild,v 1.1 2008/03/29 19:23:42 philantrop Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"hu,HU,hu_HU,Hungarian UTF-8 (Hungary),hu_HU.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"hu,HU,hyph_hu_HU,Hungarian (Hungary),hyph_hu_HU.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
"hu,HU,th_hu_HU_v2,Hungarian (Hungary),thes_hu_HU_v2.zip"
)

inherit myspell

DESCRIPTION="Hungarian dictionaries for myspell/hunspell"
LICENSE="GPL-3 GPL-2 LGPL-2.1 MPL-1.1"
HOMEPAGE="http://magyarispell.sourceforge.net/
		http://www.tipogral.hu/
		http://wiki.services.openoffice.org/wiki/Dictionaries"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
