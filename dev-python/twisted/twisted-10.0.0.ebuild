# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted/twisted-10.0.0.ebuild,v 1.2 2010/04/23 08:48:42 grobian Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit eutils distutils versionator

MY_P="TwistedCore-${PV}"

DESCRIPTION="An asynchronous networking framework written in Python"
HOMEPAGE="http://www.twistedmatrix.com/ http://pypi.python.org/pypi/Twisted"
SRC_URI="http://tmrc.mit.edu/mirror/${PN}/Core/$(get_version_component_range 1-2)/${MY_P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~ia64-hpux ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="crypt gtk serial"

DEPEND=">=net-zope/zope-interface-3.0.1
	serial? ( dev-python/pyserial )
	crypt? ( >=dev-python/pyopenssl-0.5.1 )
	gtk? ( >=dev-python/pygtk-1.99 )
	!dev-python/twisted-docs"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

DOCS="CREDITS NEWS README"

src_prepare(){
	# Give a load-sensitive test a better chance of succeeding.
	epatch "${FILESDIR}/${PN}-2.1.0-echo-less.patch"

	# Pass valid arguments to "head" in the zsh completion function.
	epatch "${FILESDIR}/${PN}-2.1.0-zsh-head.patch"

	# Respect TWISTED_DISABLE_WRITING_OF_PLUGIN_CACHE variable.
	epatch "${FILESDIR}/twisted-9.0.0-respect_TWISTED_DISABLE_WRITING_OF_PLUGIN_CACHE.patch"
}

src_test() {
	testing() {
		local return_status="0"
		"$(PYTHON)" setup.py build -b "build-${PYTHON_ABI}" install --root="${T}/tests" --no-compile || die "Installation of tests failed with Python ${PYTHON_ABI}"

		pushd "${T}/tests${EPREFIX}$(python_get_sitedir)" > /dev/null || die

		# Skip broken tests.
		rm -f twisted/python/test/test_release.py

		# Prevent it from pulling in plugins from already installed twisted packages.
		rm -f twisted/plugins/__init__.py

		# An empty file doesn't work because the tests check for
		# docstrings in all packages
		echo "'''plugins stub'''" > twisted/plugins/__init__.py || die

		if ! PYTHONPATH="." "${T}/tests${EPREFIX}/usr/bin/trial" twisted; then
			if [[ -n "${TWISTED_DEBUG_TESTS}" ]]; then
				die "Tests failed with Python ${PYTHON_ABI}"
			else
				return_status="1"
			fi
		fi

		popd > /dev/null || die
		rm -fr "${T}/tests"
		return "${return_status}"
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	python_generate_wrapper_scripts -E -f -q "${D%/}${EPREFIX}/usr/bin/trial"

	create_twisted_egg-info() {
		touch "${D%/}${EPREFIX}/$(python_get_sitedir)/Twisted-${PV}-py${PYTHON_ABI}.egg-info"
	}
	python_execute_function create_twisted_egg-info

	# Delete dropin.cache to avoid collisions.
	# dropin.cache is regenerated in pkg_postinst().
	rm -f "${D%/}${EPREFIX}/usr/$(get_libdir)"/python*/site-packages/twisted/plugins/dropin.cache

	# weird pattern to avoid installing the index.xhtml page
	doman doc/man/*.?
	insinto /usr/share/doc/${PF}
	doins -r $(find doc -mindepth 1 -maxdepth 1 -not -name man)

	newconfd "${FILESDIR}/twistd.conf" twistd
	newinitd "${FILESDIR}/twistd.init" twistd

	# zsh completion
	insinto /usr/share/zsh/site-functions/
	doins twisted/python/_twisted_zsh_stub
}

update_plugin_cache() {
	# Update dropin.cache only when Twisted is still installed.
	if [[ -f "${EROOT%/}$(python_get_sitedir)/twisted/plugin.py" ]]; then
		einfo "Regenerating plugin cache with Python ${PYTHON_ABI}"
		# http://twistedmatrix.com/documents/current/core/howto/plugin.html
		"$(PYTHON)" -c "from twisted.plugin import IPlugin, getPlugins; list(getPlugins(IPlugin))"
	fi
}

pkg_postinst() {
	distutils_pkg_postinst
	python_execute_function -q update_plugin_cache
}

pkg_postrm() {
	distutils_pkg_postrm
	python_execute_function -q update_plugin_cache
}
