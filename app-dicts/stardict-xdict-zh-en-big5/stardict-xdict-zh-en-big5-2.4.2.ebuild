# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/stardict-xdict-zh-en-big5/stardict-xdict-zh-en-big5-2.4.2.ebuild,v 1.2 2004/05/31 18:24:59 vapier Exp $

FROM_LANG="Traditional Chinese (BIG5)"
TO_LANG="English"
DICT_PREFIX="xdict-ce-"
DICT_SUFFIX="big5"

inherit stardict

HOMEPAGE="http://stardict.sourceforge.net/Dictionaries_zh_TW.php"

KEYWORDS="~x86 ~ppc"

RDEPEND=">=app-dicts/stardict-2.4.2"
