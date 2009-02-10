# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/axiom/axiom-0.5.30.ebuild,v 1.2 2009/02/10 15:35:46 lordvan Exp $

inherit twisted distutils eutils

MY_P=Axiom-${PV}

DESCRIPTION="Axiom is an object database implemented on top of SQLite."
HOMEPAGE="http://divmod.org/trac/wiki/DivmodAxiom"
SRC_URI="http://divmod.org/trac/attachment/wiki/SoftwareReleases/${MY_P}.tar.gz?format=raw -> ${MY_P}.tar.gz"
#SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~ia64 ~ppc64 ~x86 ~amd64"
IUSE=""
EAPI="2"

DEPEND="|| ( >=dev-lang/python-2.5[sqlite]
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
	if has_version ">=dev-db/sqlite-3.6.4"; then
		epatch "${FILESDIR}/${P}-sqlite3_3.6.4.patch"
	fi
}

src_compile() {
	# skip this, or epsilon will install the temporary "build" dir
	true
}

src_test() {
	PYTHONPATH=. trial axiom || die "trial failed"
}

src_install() {
	distutils_src_install
	# remove stupid dropin.cache from destdir
	rm "${D}usr/$(get_libdir)/python${PYVER}/site-packages/twisted/plugins/dropin.cache"
}

pkg_postrm() {
	twisted_pkg_postrm
}

pkg_postinst() {
	twisted_pkg_postinst
}
