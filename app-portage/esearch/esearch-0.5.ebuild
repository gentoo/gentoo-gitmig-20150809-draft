# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/esearch/esearch-0.5.ebuild,v 1.1 2003/10/19 19:36:08 genone Exp $

IUSE=""
DESCRIPTION="Replacement for 'emerge search' with search-index"
HOMEPAGE="http://www.david-peter.de/projekte.esearch-en.html"
SRC_URI="http://www.david-peter.de/downloads/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips arm"

DEPEND=">=dev-lang/python-2.2"

src_install() {
	exeinto /usr/lib/esearch
	doexe eupdatedb.py esearch.py

	dodir /usr/bin/
	dodir /usr/sbin/

	dosym /usr/lib/esearch/esearch.py /usr/bin/esearch
	dosym /usr/lib/esearch/eupdatedb.py /usr/sbin/eupdatedb

	dodoc ChangeLog ${FILESDIR}/eupdatedb.cron
}

