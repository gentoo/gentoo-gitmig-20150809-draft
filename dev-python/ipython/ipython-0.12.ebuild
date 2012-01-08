# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ipython/ipython-0.12.ebuild,v 1.1 2012/01/08 22:07:39 bicatali Exp $

EAPI=4

# python eclass cruft
PYTHON_USE_DEPEND="readline sqlite"
PYTHON_MODNAME="IPython"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[45]"

inherit distutils elisp-common eutils

DESCRIPTION="Advanced interactive shell for Python"
HOMEPAGE="http://ipython.org/"
SRC_URI="http://archive.ipython.org/release/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc emacs examples notebook +smp qt4 test wxwidgets"

CDEPEND="dev-python/pexpect
	emacs? ( app-emacs/python-mode virtual/emacs )
	smp? ( dev-python/pyzmq )
	wxwidgets? ( dev-python/wxpython )"
RDEPEND="${CDEPEND}
	notebook? ( www-servers/tornado
			dev-python/pygments
			dev-python/pyzmq )
	qt4? ( || ( dev-python/PyQt4 dev-python/pyside )
			dev-python/pygments
			dev-python/pyzmq )"
DEPEND="${CDEPEND}
	test? ( dev-python/nose )"

SITEFILE="62ipython-gentoo.el"

src_prepare() {
	sed -i \
		-e "/docdirbase/s:ipython:${PF}:" \
		setupbase.py || die "sed failed"
	if ! use doc; then
		sed -i \
			-e 's/+ manual_files//' \
			setupbase.py || die "sed failed"
	fi
	if ! use examples; then
		sed -i \
			-e 's/+ example_files//' \
			setupbase.py || die "sed failed"
	fi
}

src_compile() {
	distutils_src_compile
	use emacs && elisp-compile docs/emacs/ipython.el
}

src_test() {
	testing() {
		pushd build-${PYTHON_ABI} > /dev/null
		PYTHONPATH=lib PATH="scripts-${PYTHON_ABI}:${PTHONPATH}" \
			iptest"$([[ ${PYTHON_ABI} == 3.* ]] && echo 3)"
		popd > /dev/null
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	if use emacs; then
		pushd docs/emacs > /dev/null
		elisp-install ${PN} ${PN}.el*
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
		popd > /dev/null
	fi
}

pkg_postinst() {
	distutils_pkg_postinst
	use emacs && elisp-site-regen
}

pkg_postrm() {
	distutils_pkg_postrm
	use emacs && elisp-site-regen
}
