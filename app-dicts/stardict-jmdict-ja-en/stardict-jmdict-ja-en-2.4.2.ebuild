# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/stardict-jmdict-ja-en/stardict-jmdict-ja-en-2.4.2.ebuild,v 1.7 2005/07/10 00:43:17 swegener Exp $

FROM_LANG="Japanese"
TO_LANG="English"

inherit stardict

HOMEPAGE="http://stardict.sourceforge.net/Dictionaries_ja.php"
SRC_URI="mirror://sourceforge/stardict/${P}.tar.bz2"

LICENSE="GDLS"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND=">=app-dicts/stardict-2.4.2"

src_install() {
	stardict_src_install
	dodoc README
}
