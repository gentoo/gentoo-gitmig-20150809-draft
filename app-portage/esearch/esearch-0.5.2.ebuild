# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/esearch/esearch-0.5.2.ebuild,v 1.4 2004/01/14 03:18:41 avenj Exp $

IUSE=""
DESCRIPTION="Replacement for 'emerge search' with search-index"
HOMEPAGE="http://david-peter.de/esearch.html"
SRC_URI="http://david-peter.de/downloads/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc alpha ~hppa ~mips ~arm amd64 ~ia64"

DEPEND=">=dev-lang/python-2.2"

src_install() {
	exeinto /usr/lib/esearch
	doexe eupdatedb.py esearch.py

	dodir /usr/bin/
	dodir /usr/sbin/

	dosym /usr/lib/esearch/esearch.py /usr/bin/esearch
	dosym /usr/lib/esearch/eupdatedb.py /usr/sbin/eupdatedb

	doman esearch.1
	dodoc ChangeLog ${FILESDIR}/eupdatedb.cron
}

