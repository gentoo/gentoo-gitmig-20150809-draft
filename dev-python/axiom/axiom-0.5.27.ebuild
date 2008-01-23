# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/axiom/axiom-0.5.27.ebuild,v 1.1 2008/01/23 01:16:05 hawking Exp $

inherit distutils eutils

MY_P=Axiom-${PV}

DESCRIPTION="Axiom is an object database implemented on top of SQLite."
HOMEPAGE="http://divmod.org/trac/wiki/DivmodAxiom"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~ia64 ~ppc64 ~x86"
IUSE=""

DEPEND="|| ( >=dev-lang/python-2.5
	( >=dev-lang/python-2.4 >=dev-python/pysqlite-2.0 ) )
	>=dev-db/sqlite-3.2.1
	>=dev-python/twisted-2.4
	>=dev-python/twisted-conch-0.7.0-r1
	=dev-python/epsilon-0.5*"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

DOCS="NAME.txt"

src_unpack() {
	distutils_src_unpack

	epatch "${FILESDIR}/${P}-sqlite3.patch"
}

src_compile() {
	# skip this, or epsilon will install the temporary "build" dir
	true
}

src_test() {
	PYTHONPATH=. trial axiom || die "trial failed"
}
