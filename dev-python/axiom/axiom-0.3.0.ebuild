# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/axiom/axiom-0.3.0.ebuild,v 1.2 2006/02/13 23:07:53 marienz Exp $

inherit distutils eutils

DESCRIPTION="Axiom is an object database implemented on top of SQLite."
HOMEPAGE="http://divmod.org/trac/wiki/DivmodAxiom"
SRC_URI="mirror://gentoo/Axiom-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4
	>=dev-db/sqlite-3.2.1
	>=dev-python/twisted-2.1
	>=dev-python/pysqlite-2.0
	>=dev-python/epsilon-0.1"

S="${WORKDIR}/Axiom-${PV}"

DOCS="NAME.txt"

src_compile() {
	# skip this, or epsilon will install the temporary "build" dir
	true
}

src_test() {
	trial axiom || die "trial failed"
}
