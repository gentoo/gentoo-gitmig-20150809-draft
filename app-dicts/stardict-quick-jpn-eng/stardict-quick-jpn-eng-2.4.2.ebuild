# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/stardict-quick-jpn-eng/stardict-quick-jpn-eng-2.4.2.ebuild,v 1.7 2007/02/01 14:53:14 blubb Exp $

FROM_LANG="Japanese Romaji"
TO_LANG="English"
DICT_PREFIX="quick_"

inherit stardict

HOMEPAGE="http://stardict.sourceforge.net/Dictionaries_Quick.php"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=app-dicts/stardict-2.4.2"
