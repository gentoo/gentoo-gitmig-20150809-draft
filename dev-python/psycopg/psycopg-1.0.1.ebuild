# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Leo Lipelis <aeoo@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/skel.build,v 1.11 2001/12/06 22:12:34 drobbins Exp

S=${WORKDIR}/${P}

DESCRIPTION="PostgreSQL database adapter for the Python" # best one

SRC_URI="http://initd.org/pub/software/psycopg/${P}.tar.gz"

HOMEPAGE="http://www.initd.org/software/psycopg.py"

DEPEND="
	>=dev-lang/python-2.0
	>=dev-python/egenix-mx-base-2.0.3
	>=dev-db/postgresql-7.1.3"

src_compile() {
	./configure \
		--with-mxdatetime-includes=/usr/lib/python2.2/site-packages/mx/DateTime/mxDateTime \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
	#make || die
}

src_install () {
	cd ${S}
	[ -f "Makefile.orig" ] && die
	mv Makefile Makefile.orig
	cat Makefile.orig | sed \
			-e 's:\(echo "  install -m 555 $$mod \)\($(PY_MOD_DIR)\)\("; \\\):\1${D}\2/$$mod\3:' \
			-e 's:\($(INSTALL)  -m 555 $$mod \)\($(PY_MOD_DIR)\)\(; \\\):\1${D}\2/$$mod\3:' > Makefile
	make install || die
	dodir /usr/share/doc/${P}
	cp -r doc ${D}/usr/share/doc/${P}
	dodoc AUTHORS ChangeLog COPYING CREDITS INSTALL README NEWS RELEASE-1.0 SUCCESS TODO
}
