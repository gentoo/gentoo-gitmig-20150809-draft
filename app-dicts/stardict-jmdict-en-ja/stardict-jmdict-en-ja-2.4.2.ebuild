# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/stardict-jmdict-en-ja/stardict-jmdict-en-ja-2.4.2.ebuild,v 1.1 2004/01/07 17:23:24 liquidx Exp $

FROM_LANG="English"
TO_LANG="Japanese"

inherit stardict

HOMEPAGE="http://stardict.sourceforge.net/Dictionaries_ja.php"
SRC_URI="mirror://sourceforge/stardict/${P}.tar.bz2"

LICENSE="GDLS"
KEYWORDS="~x86 ~ppc"
RDEPEND=">=app-dicts/stardict-2.4.2"
S=${WORKDIR}/${P}

src_install() {
	stardict_src_install
	dodoc README
}

