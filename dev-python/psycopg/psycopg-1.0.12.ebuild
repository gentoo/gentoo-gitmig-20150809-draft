# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/psycopg/psycopg-1.0.12.ebuild,v 1.6 2004/03/28 12:32:24 kloeri Exp $

S=${WORKDIR}/${P}

DESCRIPTION="PostgreSQL database adapter for the Python" # best one

SRC_URI="http://initd.org/pub/software/psycopg/PSYCOPG-1-0/${P}.tar.gz"

HOMEPAGE="http://www.initd.org/software/psycopg.py"

DEPEND=">=dev-lang/python-2.0
	>=dev-python/egenix-mx-base-2.0.3
	>=dev-db/postgresql-7.1.3"

SLOT="0"
KEYWORDS="x86 ~sparc ~alpha"
LICENSE="GPL-2"

src_compile() {
	./configure \
		--with-mxdatetime-includes=/usr/lib/python2.2/site-packages/mx/DateTime/mxDateTime \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--with-postgres-includes=/usr/include/postgresql/server \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	cd ${S}
	[ -f "Makefile.orig" ] && die
	mv Makefile Makefile.orig
	cat Makefile.orig | sed \
			-e 's:\(echo "  install -m 555 $$mod \)\($(PY_MOD_DIR)\)\("; \\\):\1${D}\2/$$mod\3:' \
			-e 's:\($(INSTALL)  -m 555 $$mod \)\($(PY_MOD_DIR)\)\(; \\\):\1${D}\2/$$mod\3:' > Makefile
	make install || die
	dodir /usr/share/doc/${PF}
	cp -r doc ${D}/usr/share/doc/${PF}
	dodoc AUTHORS ChangeLog COPYING CREDITS INSTALL README NEWS RELEASE-1.0 SUCCESS TODO
}
