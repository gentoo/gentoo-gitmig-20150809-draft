# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/stardict-jmdict-en-ja/stardict-jmdict-en-ja-2.1.1.ebuild,v 1.5 2005/01/01 13:00:25 eradicator Exp $

FROM_LANG="English"
TO_LANG="Japanese"

inherit stardict

SRC_URI="http://www-lce.eng.cam.ac.uk/~acnt2/code/${P}.tar"

LICENSE="GDLS"

S=${WORKDIR}

src_install() {
	stardict_src_install
	dodoc README
}
