# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/axiom/axiom-0.6.0.ebuild,v 1.1 2009/11/30 12:46:51 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

# setup.py uses epsilon.setuphelper.autosetup(), which tries to use
# build-${PYTHON_ABI} directories as packages.
DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"

inherit distutils eutils twisted

MY_PN="Axiom"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Axiom is an object database implemented on top of SQLite."
HOMEPAGE="http://divmod.org/trac/wiki/DivmodAxiom http://pypi.python.org/pypi/Axiom"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc64 ~x86"
IUSE=""

DEPEND="|| ( >=dev-lang/python-2.5[sqlite]
	( >=dev-lang/python-2.4 >=dev-python/pysqlite-2.0 ) )
	>=dev-db/sqlite-3.2.1
	>=dev-python/twisted-2.4
	>=dev-python/twisted-conch-0.7.0-r1
	>=dev-python/epsilon-0.6"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

S=${WORKDIR}/${MY_P}

DOCS="NAME.txt"

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.5.30-sqlite3.patch"
	epatch "${FILESDIR}/${PN}-0.5.30-sqlite3_3.6.4.patch"
	python_copy_sources
}

src_compile() {
	# Skip distutils_src_compile to avoid installation of $(python_get_sitedir)/build directory.
	:
}

src_test() {
	testing() {
		PYTHONPATH="." trial axiom
	}
	python_execute_function testing
}

src_install() {
	PORTAGE_PLUGINCACHE_NOOP="1" distutils_src_install
}

update_axiom_plugin_cache() {
	einfo "Updating axiom plugin cache..."
	"$(PYTHON)" -c 'from twisted.plugin import IPlugin, getPlugIns;from axiom import plugins; list(getPlugIns(IPlugin, plugins))'
}

pkg_postrm() {
	twisted_pkg_postrm
	python_execute_function update_axiom_plugin_cache
}

pkg_postinst() {
	twisted_pkg_postinst
	python_execute_function update_axiom_plugin_cache
}
