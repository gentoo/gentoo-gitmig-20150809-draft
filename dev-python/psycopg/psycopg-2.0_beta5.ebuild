# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/psycopg/psycopg-2.0_beta5.ebuild,v 1.3 2005/11/14 16:53:36 seemant Exp $

inherit distutils

MY_PV=${PV/_beta/b}
DESCRIPTION="PostgreSQL database adapter for Python."
SRC_URI="http://initd.org/pub/software/psycopg/${PN}2-${MY_PV}.tar.gz"
HOMEPAGE="http://initd.org/projects/psycopg2"

DEPEND=">=dev-lang/python-2.4
	>=dev-db/postgresql-7.1.3"

SLOT="2"
KEYWORDS="~x86"
LICENSE="GPL-2"
IUSE=""

S=${WORKDIR}/${PN}2-${MY_PV}

DOCS="AUTHORS ChangeLog COPYING CREDITS INSTALL README NEWS docs/*"

src_install () {
	distutils_src_install
	insinto /usr/share/doc/${PF}/examples
	doins   examples/*
}
