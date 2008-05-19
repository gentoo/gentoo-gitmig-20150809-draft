# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/psycopg/psycopg-2.0.2.ebuild,v 1.11 2008/05/19 19:47:13 dev-zero Exp $

inherit eutils distutils

DESCRIPTION="PostgreSQL database adapter for Python."
SRC_URI="http://initd.org/pub/software/psycopg/${PN}2-${PV}.tar.gz"
HOMEPAGE="http://initd.org/projects/psycopg2"

DEPEND=">=dev-lang/python-2.4
	>=virtual/postgresql-base-7.4"

SLOT="2"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
LICENSE="GPL-2"
IUSE="debug"

S=${WORKDIR}/${PN}2-${PV}

DOCS="AUTHORS ChangeLog CREDITS README"

src_unpack() {
	unpack ${A}
	if ! use debug; then
		epatch ${FILESDIR}/${P}-nodebug.patch
	fi
}

src_install () {
	distutils_src_install
	insinto /usr/share/doc/${PF}/examples
	doins   examples/*
}
