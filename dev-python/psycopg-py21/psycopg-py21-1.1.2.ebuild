# Copyright 2002-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/psycopg-py21/psycopg-py21-1.1.2.ebuild,v 1.4 2003/06/22 12:15:59 liquidx Exp $

P_NEW="${PN%-py21}-${PV}"
S="${WORKDIR}/${P_NEW}"

DESCRIPTION="PostgreSQL database adapter for the Python" # best one
SRC_URI="http://initd.org/pub/software/psycopg/${P_NEW}.tar.gz"
HOMEPAGE="http://www.initd.org/software/psycopg.py"
DEPEND="=dev-lang/python-2.1*
	>=dev-python/egenix-mx-base-py21-2.0.4
	>=dev-db/postgresql-7.1.3"

SLOT="0"
KEYWORDS="x86 ~ppc"
LICENSE="GPL-2"

src_compile() {
	./configure \
		--with-mxdatetime-includes=/usr/lib/python2.1/site-packages/mx/DateTime/mxDateTime \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--with-postgres-includes=/usr/include/postgresql/server \
		--mandir=/usr/share/man \
		--with-python=/usr/bin/python2.1 \
		--with-python-version=2.1 || die "./configure failed"
	emake || die
}

src_install () {
	cd ${S}
	[ -f "Makefile.orig" ] && die
	mv Makefile Makefile.orig
	sed \
		-e 's:\(echo "  install -m 555 $$mod \)\($(PY_MOD_DIR)\)\("; \\\):\1${D}\2/$$mod\3:' \
		-e 's:\($(INSTALL)  -m 555 $$mod \)\($(PY_MOD_DIR)\)\(; \\\):\1${D}\2/$$mod\3:' Makefile.orig > Makefile
	make install || die

	dodoc AUTHORS ChangeLog COPYING CREDITS INSTALL README NEWS RELEASE-1.0 SUCCESS TODO
	docinto doc
	dodoc   doc/*
	docinto doc/examples
	dodoc   doc/examples/*
}
