# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zpsycopgda/zpsycopgda-1.1.15.ebuild,v 1.2 2006/01/27 02:53:39 vapier Exp $

inherit zproduct

DESCRIPTION="PostgreSQL database adapter for Zope"
HOMEPAGE="http://www.initd.org/software/psycopg.py"
SRC_URI="http://initd.org/pub/software/psycopg/psycopg-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~ppc x86"

RDEPEND=">=dev-python/psycopg-${PV}"

S=${WORKDIR}/psycopg-${PV}

ZPROD_LIST="ZPsycopgDA"

src_compile() {
	rm -f * >& /dev/null
	rm -fR debian/ doc/ tests/
}
