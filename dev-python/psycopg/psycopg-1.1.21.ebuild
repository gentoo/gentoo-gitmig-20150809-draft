# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/psycopg/psycopg-1.1.21.ebuild,v 1.12 2008/05/19 19:47:13 dev-zero Exp $

inherit python

DESCRIPTION="PostgreSQL database adapter for Python" # best one
SRC_URI="http://initd.org/pub/software/psycopg/${P}.tar.gz"
HOMEPAGE="http://www.initd.org/software/psycopg"

DEPEND="virtual/python
	>=dev-python/egenix-mx-base-2.0.3
	>=virtual/postgresql-base-7.1.3"

SLOT="0"
KEYWORDS="alpha ~amd64 ia64 ppc ppc64 sparc x86"
LICENSE="GPL-2"
IUSE=""

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# fix for bug #134873
	sed -e '1245s/static //' -i cursor.c
}

src_compile() {
	python_version
	econf \
		--with-mxdatetime-includes=/usr/lib/python${PYVER}/site-packages/mx/DateTime/mxDateTime \
		--with-postgres-includes=/usr/include/postgresql/server \
		|| die "./configure failed"
	emake || die
}

src_install () {
	cd ${S}
	sed -e 's:\(echo "  install -m 555 $$mod \)\($(PY_MOD_DIR)\)\("; \\\):\1${D}\2/$$mod\3:' \
		-e 's:\($(INSTALL)  -m 555 $$mod \)\($(PY_MOD_DIR)\)\(; \\\):\1${D}\2/$$mod\3:' \
		-i Makefile
	make install || die

	dodoc AUTHORS ChangeLog COPYING CREDITS INSTALL README NEWS RELEASE-1.0 SUCCESS TODO
	docinto doc
	dodoc   doc/*
	insinto /usr/share/doc/${PF}/examples
	doins   doc/examples/*
}
