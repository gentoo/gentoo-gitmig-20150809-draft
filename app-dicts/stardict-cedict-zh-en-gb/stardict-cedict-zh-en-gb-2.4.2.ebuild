# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/stardict-cedict-zh-en-gb/stardict-cedict-zh-en-gb-2.4.2.ebuild,v 1.1 2004/01/07 17:08:23 liquidx Exp $

FROM_LANG="Simplified Chinese (GB)"
TO_LANG="English"
DICT_PREFIX="cedict-"
DICT_SUFFIX="gb"

inherit stardict

HOMEPAGE="http://stardict.sourceforge.net/Dictionaries_zh_CN.php"
RDEPEND=">=app-dicts/stardict-2.4.2"
