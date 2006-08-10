# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/psycopg/psycopg-2.0.4.ebuild,v 1.2 2006/08/10 21:20:18 liquidx Exp $

inherit eutils distutils

MY_P="${PN}2-${PV}"

DESCRIPTION="PostgreSQL database adapter for Python."
SRC_URI="http://initd.org/pub/software/psycopg/${MY_P}.tar.gz"
HOMEPAGE="http://initd.org/projects/psycopg2"

DEPEND=">=dev-lang/python-2.4
	>=dev-db/libpq-7.4"

SLOT="2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
LICENSE="GPL-2"
IUSE="debug"

S="${WORKDIR}/${MY_P}"
DOCS="AUTHORS INSTALL LICENSE doc/HACKING doc/SUCCESS doc/TODO doc/async.txt"

src_unpack() {
	unpack ${A}
	cd "${S}"

	if use debug; then
		epatch ${FILESDIR}/${P}-debug.patch
	fi
}

src_install() {
	distutils_src_install

	insinto /usr/share/doc/${PF}/examples
	doins examples/*

	cd doc && dohtml -r .
}
