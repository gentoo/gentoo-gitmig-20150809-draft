# Copyright 2002-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zpsycopgda/zpsycopgda-1.1.2.ebuild,v 1.1 2003/03/09 00:26:49 kutsuya Exp $

inherit zproduct 
S="${WORKDIR}/psycopg-${PV}/"

DESCRIPTION="PostgreSQL database adapter for Zope."
SRC_URI="http://initd.org/pub/software/psycopg/psycopg-${PV}.tar.gz"
HOMEPAGE="http://www.initd.org/software/psycopg.py"
DEPEND="=dev-python/psycopg-py21-${PV}
	${DEPEND}"
KEYWORDS="~x86"
LICENSE="GPL-2"

ZPROD_LIST="ZPsycopgDA"

src_compile()
{
	rm -f * >& /dev/null
	rm -fR debian/ doc/ tests/ 
}
