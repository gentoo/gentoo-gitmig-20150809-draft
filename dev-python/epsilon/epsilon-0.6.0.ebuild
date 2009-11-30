# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/epsilon/epsilon-0.6.0.ebuild,v 1.2 2009/11/30 02:51:14 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

# setup.py uses epsilon.setuphelper.autosetup(), which tries to use
# build-${PYTHON_ABI} directories as packages.
DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"

inherit distutils twisted

MY_PN="Epsilon"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Epsilon is a Python utilities package, most famous for its Time class."
HOMEPAGE="http://divmod.org/trac/wiki/DivmodEpsilon http://pypi.python.org/pypi/Epsilon"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc64 ~x86"
IUSE=""

DEPEND=">=dev-python/twisted-2.4"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

DOCS="NAME.txt NEWS.txt"

src_prepare() {
	# Rename to avoid file-collisions
	mv bin/benchmark bin/epsilon-benchmark
	sed -i \
		-e "s#bin/benchmark#bin/epsilon-benchmark#" \
		setup.py || die "sed failed"
	# otherwise we get sandbox violations as it wants to update
	# the plugin cache
	epatch "${FILESDIR}/epsilon_plugincache_portagesandbox.patch"

	python_copy_sources
}

src_compile() {
	# Skip distutils_src_compile to avoid installation of $(python_get_sitedir)/build directory.
	:
}

src_test() {
	# Release tests need DivmodCombinator.
	rm -f epsilon/test/test_release.py*

	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" trial epsilon
	}
	python_execute_function testing
}

pkg_postrm() {
	twisted_pkg_postrm
}

pkg_postinst() {
	twisted_pkg_postinst
}
