# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/stardict-quick-jpn-eng/stardict-quick-jpn-eng-2.4.2.ebuild,v 1.5 2005/01/01 13:02:08 eradicator Exp $

FROM_LANG="Japanese Romaji"
TO_LANG="English"
DICT_PREFIX="quick_"

inherit stardict

HOMEPAGE="http://stardict.sourceforge.net/Dictionaries_Quick.php"

KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND=">=app-dicts/stardict-2.4.2"
