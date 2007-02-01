# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/stardict-freedict-eng-lat/stardict-freedict-eng-lat-2.4.2.ebuild,v 1.10 2007/02/01 14:42:04 blubb Exp $

FROM_LANG="English"
TO_LANG="Latin"
DICT_PREFIX="dictd_www.freedict.de_"

inherit stardict

HOMEPAGE="http://stardict.sourceforge.net/Dictionaries_dictd-www.freedict.de.php"

KEYWORDS="~amd64 ppc sparc x86"
IUSE=""

RDEPEND=">=app-dicts/stardict-2.4.2"
