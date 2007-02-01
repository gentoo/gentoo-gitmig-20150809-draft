# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/stardict-quick-eng-jpn/stardict-quick-eng-jpn-2.4.2.ebuild,v 1.7 2007/02/01 14:52:44 blubb Exp $

FROM_LANG="English"
TO_LANG="Japanese Romaji"
DICT_PREFIX="quick_"

inherit stardict

HOMEPAGE="http://stardict.sourceforge.net/Dictionaries_Quick.php"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=app-dicts/stardict-2.4.2"
