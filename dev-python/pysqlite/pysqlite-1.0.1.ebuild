# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysqlite/pysqlite-1.0.1.ebuild,v 1.12 2012/01/14 16:42:38 maekke Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="Python wrapper for the local database Sqlite"
HOMEPAGE="http://pysqlite.org/"
SRC_URI="mirror://sourceforge/pysqlite/pysqlite-${PV}.tar.gz"

LICENSE="pysqlite"
SLOT="0"
KEYWORDS="amd64 ~arm ppc sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-db/sqlite:0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

PYTHON_MODNAME="sqlite"

src_install() {
	distutils_src_install

	insinto /usr/share/doc/${PF}/examples || die
	doins -r examples/* || die
}
