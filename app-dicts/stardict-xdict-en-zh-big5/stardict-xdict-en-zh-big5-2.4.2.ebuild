# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/stardict-xdict-en-zh-big5/stardict-xdict-en-zh-big5-2.4.2.ebuild,v 1.1 2004/01/07 17:27:40 liquidx Exp $

FROM_LANG="English"
TO_LANG="Traditional Chinese (BIG5)"
DICT_PREFIX="xdict-ec-"
DICT_SUFFIX="big5"

inherit stardict

HOMEPAGE="http://stardict.sourceforge.net/Dictionaries_zh_TW.php"
KEYWORDS="~x86 ~ppc"
RDEPEND=">=app-dicts/stardict-2.4.2"
