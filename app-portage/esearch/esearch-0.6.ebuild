# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/esearch/esearch-0.6.ebuild,v 1.2 2004/02/09 00:35:03 genone Exp $

DESCRIPTION="Replacement for 'emerge search' with search-index"
HOMEPAGE="http://david-peter.de/esearch.html"
SRC_URI="http://david-peter.de/downloads/${P}.tar.bz2"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm ~amd64 ~ia64"

DEPEND=">=dev-lang/python-2.2"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:/usr/portage/lib:/usr/lib/portage:' *
}

src_install() {
	exeinto /usr/lib/esearch
	doexe eupdatedb.py esearch.py esync.py

	dodir /usr/bin/
	dodir /usr/sbin/

	dosym /usr/lib/esearch/esearch.py /usr/bin/esearch
	dosym /usr/lib/esearch/eupdatedb.py /usr/sbin/eupdatedb
	dosym /usr/lib/esearch/esync.py /usr/sbin/esync

	doman esearch.1
	dodoc ChangeLog ${FILESDIR}/eupdatedb.cron
}

