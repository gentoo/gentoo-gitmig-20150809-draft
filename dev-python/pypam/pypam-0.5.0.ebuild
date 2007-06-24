# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pypam/pypam-0.5.0.ebuild,v 1.2 2007/06/24 14:18:26 angelos Exp $

inherit distutils eutils

MY_P=${P/pypam/PyPAM}

DESCRIPTION="Python Bindings for PAM (Pluggable Authentication Modules)"
HOMEPAGE="http://www.pangalactic.org/PyPAM"
SRC_URI="http://www.pangalactic.org/PyPAM/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-libs/pam-0.64"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

DOCS="AUTHORS examples/pamtest.py"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix a PyObject/PyMEM mixup.
	epatch "${FILESDIR}/${P}-python-2.5.patch"
	# Fix a missing include.
	epatch "${FILESDIR}/${P}-stricter.patch"
}

src_test() {
	"${python}" setup.py install --home="${T}/test" \
		|| die "testinstall failed"
	PYTHONPATH="${T}/test/$(get_libdir)/python" "${python}" tests/PamTest.py \
		|| die "tests failed"
}

pkg_postinst() {
	# HACK: we do not install any .py files, so there is no reason to
	# run python_mod_optimize here, like distutils_pkg_postrm does.
	:
}

pkg_postrm() {
	# HACK: we do not install any .py files, so there is no reason to
	# run python_mod_cleanup here, like distutils_pkg_postrm does.
	:
}
