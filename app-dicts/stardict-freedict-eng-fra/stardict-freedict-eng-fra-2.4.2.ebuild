# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/stardict-freedict-eng-fra/stardict-freedict-eng-fra-2.4.2.ebuild,v 1.1 2004/01/07 17:19:18 liquidx Exp $

FROM_LANG="English"
TO_LANG="French"
DICT_PREFIX="dictd_www.freedict.de_"

inherit stardict


HOMEPAGE="http://stardict.sourceforge.net/Dictionaries_dictd-www.freedict.de.php"
KEYWORDS="~x86 ~ppc"
RDEPEND=">=app-dicts/stardict-2.4.2"
