# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/dbbalancer/dbbalancer-0.4.4.ebuild,v 1.10 2004/03/20 07:03:04 mr_bones_ Exp $

DESCRIPTION="Load balancing multithreaded PostgreSQL connection pool.
Also has a replication mode to keep in sync the load balanced backend
servers."
HOMEPAGE="http://sourceforge.net/projects/dbbalancer"
SRC_URI="mirror://sourceforge/dbbalancer/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=dev-db/postgresql-7.2.3-r1
	>=dev-libs/ace-5.2.4-r1
	>=app-text/openjade-1.3.1-r5
	=app-text/docbook-dsssl-stylesheets-1.77"

S="${WORKDIR}/DBBalancer"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch ./Makefile.in ${FILESDIR}/${P}-Makefile.in-gentoo.diff
	patch ./src/tests/postgres_cc/pgtest.cc ${FILESDIR}/${P}-pgtest.cc-gentoo.diff
	patch ./docs/manual/chapter2.sgml ${FILESDIR}/${P}-chapter2.sgml-gentoo.diff
	patch ./docs/manual/chapter6.sgml ${FILESDIR}/${P}-chapter6.sgml-gentoo.diff
}

#		--with-pq++=/usr \
src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--with-ACE=/usr \
		--with-pq=/usr \
		--with-pq-include=/usr/include/postgresql \
		--with-jade=/usr/bin/jade \
		--with-docbook=/usr/share/sgml/docbook/dsssl-stylesheets-1.77 \
			|| die "./configure failed"
	emake || die "emake failed"
	export SANDBOX_DISABLED=1
}

src_install() {
	dosbin ${WORKDIR}/DBBalancer/dbbalancerd
}
