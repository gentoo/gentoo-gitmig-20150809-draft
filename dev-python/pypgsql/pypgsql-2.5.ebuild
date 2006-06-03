# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pypgsql/pypgsql-2.5.ebuild,v 1.1 2006/06/03 13:06:20 lucass Exp $

inherit distutils

MY_P="pyPgSQL-${PV}"
DESCRIPTION="Python Interface to PostgreSQL"
HOMEPAGE="http://pypgsql.sourceforge.net/"
SRC_URI="mirror://sourceforge/pypgsql/${MY_P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ia64 ~x86"
SLOT="0"
IUSE=""
DEPEND="dev-db/postgresql"
S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="pyPgSQL"

src_install() {
	distutils_src_install

	dodoc Announce
	insinto /usr/share/doc/${PF}/examples
	doins examples/*
}
