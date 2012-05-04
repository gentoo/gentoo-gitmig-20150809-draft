# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycairo/pycairo-1.10.0.ebuild,v 1.2 2012/05/04 15:12:14 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6 3:3.1"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.0 *-jython"

inherit eutils multilib python waf-utils

PYCAIRO_PYTHON2_VERSION="1.8.10"
PYCAIRO_PYTHON3_VERSION="${PV}"

DESCRIPTION="Python bindings for the cairo library"
HOMEPAGE="http://cairographics.org/pycairo/ http://pypi.python.org/pypi/pycairo"
SRC_URI="http://cairographics.org/releases/py2cairo-${PYCAIRO_PYTHON2_VERSION}.tar.gz
	http://cairographics.org/releases/pycairo-${PYCAIRO_PYTHON3_VERSION}.tar.bz2"

# LGPL-3 for pycairo 1.10.0.
# || ( LGPL-2.1 MPL-1.1 ) for pycairo 1.8.10.
LICENSE="LGPL-3 || ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="doc examples +svg test"

RDEPEND=">=x11-libs/cairo-1.10.0[svg?]"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	test? ( dev-python/pytest )"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

src_prepare() {
	pushd "${WORKDIR}/pycairo-${PYCAIRO_PYTHON3_VERSION}" > /dev/null
	epatch "${FILESDIR}/${PN}-1.10.0-svg_check.patch"
	popd > /dev/null

	pushd "${WORKDIR}/pycairo-${PYCAIRO_PYTHON2_VERSION}" > /dev/null
	epatch "${FILESDIR}/${PN}-1.8.8-svg_check.patch"
	epatch "${FILESDIR}/${PN}-1.8.10-pkgconfig_dir.patch"
	epatch "${FILESDIR}/${PN}-1.8.10-cairo.version_info.patch"
	popd > /dev/null

	preparation() {
		if [[ "${PYTHON_ABI}" == 3.* ]]; then
			cp -r "${WORKDIR}/pycairo-${PYCAIRO_PYTHON3_VERSION}" "${WORKDIR}/${P}-${PYTHON_ABI}"
		else
			cp -r "${WORKDIR}/pycairo-${PYCAIRO_PYTHON2_VERSION}" "${WORKDIR}/${P}-${PYTHON_ABI}"
		fi
	}
	python_execute_function preparation
}

src_configure() {
	if ! use svg; then
		export PYCAIRO_DISABLE_SVG="1"
	fi

	configuration() {
		if [[ "${PYTHON_ABI}" == 3.* ]]; then
			waf-utils_src_configure --nopyc --nopyo
		fi
	}
	python_execute_function -s configuration
}

src_compile() {
	building() {
		if [[ "${PYTHON_ABI}" == 3.* ]]; then
			waf-utils_src_compile
		else
			echo ${_BOLD}"$(PYTHON)" setup.py build${_NORMAL}
			"$(PYTHON)" setup.py build
		fi
	}
	python_execute_function -s building
}

src_test() {
	test_installation() {
		if [[ "${PYTHON_ABI}" == 3.* ]]; then
			./waf install --destdir="${T}/tests/${PYTHON_ABI}"
		else
			"$(PYTHON)" setup.py install --no-compile --root="${T}/tests/${PYTHON_ABI}"
		fi
	}
	python_execute_function -q -s test_installation

	python_execute_py.test -P '${T}/tests/${PYTHON_ABI}${EPREFIX}$(python_get_sitedir)' -s
}

src_install() {
	installation() {
		if [[ "${PYTHON_ABI}" == 3.* ]]; then
			waf-utils_src_install
		else
			echo ${_BOLD}"$(PYTHON)" setup.py install --no-compile --root="${D}"${_NORMAL}
			PKGCONFIG_DIR="${EPREFIX}/usr/$(get_libdir)/pkgconfig" "$(PYTHON)" setup.py install --no-compile --root="${D}"
		fi
	}
	python_execute_function -s installation

	dodoc AUTHORS NEWS README || die "dodoc failed"

	if use doc; then
		pushd doc/_build/html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _static || die "Installation of documentation failed"
		popd > /dev/null
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/* || die "Installation of examples failed"
	fi
}

pkg_postinst() {
	python_mod_optimize cairo
}

pkg_postrm() {
	python_mod_cleanup cairo
}
