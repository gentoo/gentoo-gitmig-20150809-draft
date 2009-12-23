# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/psycopg/psycopg-1.1.21.ebuild,v 1.15 2009/12/23 21:23:45 arfrever Exp $

EAPI="2"

inherit python

DESCRIPTION="PostgreSQL database adapter for Python" # best one
SRC_URI="http://initd.org/pub/software/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.initd.org/software/psycopg"

SLOT="0"
KEYWORDS="alpha ~amd64 ia64 ppc ppc64 sparc x86"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=dev-python/egenix-mx-base-2.0.3
	>=virtual/postgresql-base-7.1.3"
RDEPEND="${DEPEND}"

src_prepare() {
	# fix for bug #134873
	sed -e '1245s/static //' -i cursor.c
}

src_configure() {
	econf \
		--with-mxdatetime-includes="$(python_get_includedir)/mx" \
		--with-postgres-includes="/usr/include/postgresql/server"
}

src_install () {
	sed -e 's:\(echo "  install -m 555 $$mod \)\($(PY_MOD_DIR)\)\("; \\\):\1${D}\2/$$mod\3:' \
		-e 's:\($(INSTALL)  -m 555 $$mod \)\($(PY_MOD_DIR)\)\(; \\\):\1${D}\2/$$mod\3:' \
		-i Makefile
	emake install || die "emake install failed"

	dodoc AUTHORS ChangeLog CREDITS README NEWS RELEASE-1.0 SUCCESS TODO
	docinto doc
	dodoc   doc/*
	insinto /usr/share/doc/${PF}/examples
	doins   doc/examples/*
}
