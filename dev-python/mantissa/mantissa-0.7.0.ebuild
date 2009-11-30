# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mantissa/mantissa-0.7.0.ebuild,v 1.2 2009/11/30 16:20:32 mr_bones_ Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

# setup.py uses epsilon.setuphelper.autosetup(), which tries to use
# build-${PYTHON_ABI} directories as packages.
DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"

inherit distutils twisted

MY_PN="Mantissa"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="An extensible, multi-protocol, multi-user, interactive application server"
HOMEPAGE="http://divmod.org/trac/wiki/DivmodMantissa http://pypi.python.org/pypi/Mantissa"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/axiom-0.5.7
	>=dev-python/cssutils-0.9.5.1
	>=dev-python/imaging-1.1.6
	>=dev-python/nevow-0.9.5
	>=dev-python/pytz-2005m
	>=dev-python/twisted-8.0.1
	dev-python/twisted-mail
	>=dev-python/vertex-0.2.0"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

DOCS="NAME.txt NEWS.txt"
PYTHON_MODNAME="axiom nevow xmantissa"

src_compile() {
	# Skip distutils_src_compile to avoid installation of $(python_get_sitedir)/build directory.
	:
}

src_test() {
	testing() {
		PYTHONPATH="." trial xmantissa
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

update_mantissa_plugin_cache() {
	einfo "Updating mantissa plugin cache..."
	"$(PYTHON)" -c 'from twisted.plugin import IPlugin, getPlugIns;from xmantissa import plugins; list(getPlugIns(IPlugin, plugins))'
}

update_nevow_plugin_cache() {
	einfo "Updating nevow plugin cache..."
	"$(PYTHON)" -c 'from twisted.plugin import IPlugin, getPlugIns;from nevow import plugins; list(getPlugIns(IPlugin, plugins))'
}

pkg_postinst() {
	twisted_pkg_postinst
	python_execute_function update_axiom_plugin_cache
	python_execute_function update_nevow_plugin_cache
	python_execute_function update_mantissa_plugin_cache
}

pkg_postrm() {
	twisted_pkg_postrm
	python_execute_function update_axiom_plugin_cache
	python_execute_function update_nevow_plugin_cache
	python_execute_function update_mantissa_plugin_cache
}
