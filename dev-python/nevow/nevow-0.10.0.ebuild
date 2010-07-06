# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nevow/nevow-0.10.0.ebuild,v 1.9 2010/07/06 15:44:20 ssuominen Exp $

EAPI="2"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="trial formless nevow"
DISTUTILS_DISABLE_TEST_DEPENDENCY="1"

inherit distutils multilib twisted

MY_PN="Nevow"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A web templating framework that provides LivePage, an automatic AJAX toolkit."
HOMEPAGE="http://divmod.org/trac/wiki/DivmodNevow http://pypi.python.org/pypi/Nevow"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 sparc x86 ~x86-linux"
IUSE="doc"

DEPEND=">=dev-python/twisted-2.5
	>=dev-python/twisted-web-8.1.0
	net-zope/zope-interface"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="formless nevow"

src_test() {
	TWISTED_DISABLE_WRITING_OF_PLUGIN_CACHE="1" distutils_src_test
}

src_install() {
	distutils_src_install

	doman doc/man/nevow-xmlgettext.1
	if use doc; then
		insinto /usr/share/doc/${PF}/
		doins -r doc/{howto,html,old} examples
	fi
	rm -fr "${D}usr/doc"
}

update_nevow_plugin_cache() {
	einfo "Updating nevow plugin cache..."
	"$(PYTHON)" -c 'from twisted.plugin import IPlugin, getPlugins;from nevow import plugins; list(getPlugins(IPlugin, plugins))'
}

pkg_postrm() {
	twisted_pkg_postrm
	python_execute_function update_nevow_plugin_cache
}

pkg_postinst() {
	twisted_pkg_postinst
	python_execute_function update_nevow_plugin_cache
}
