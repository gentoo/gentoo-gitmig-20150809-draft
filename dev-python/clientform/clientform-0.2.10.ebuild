# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/clientform/clientform-0.2.10.ebuild,v 1.5 2009/10/30 10:57:13 maekke Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_P="ClientForm-${PV}"
DESCRIPTION="Parse, fill out, and return HTML forms on the client side"
HOMEPAGE="http://wwwsearch.sourceforge.net/ClientForm/"
SRC_URI="http://wwwsearch.sourceforge.net/ClientForm/src/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc x86 ~amd64-linux ~ia64-linux ~x86-linux ~x86-macos"
IUSE="examples"

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="ClientForm.py"
DOCS="*.txt"

src_prepare() {
	# Use distutils instead of setuptools.
	# (This can't be removed in the same ${PV} due to file->directory replacement.)
	sed -e 's/not hasattr(sys, "version_info")/True/' -i setup.py || die "sed failed"
}

src_test() {
	testing() {
		"$(PYTHON)" test.py
	}
	python_execute_function testing
}

src_install() {
	# Remove some files to prevent distutils_src_install from installing them.
	dohtml *.html
	rm -f README.html*

	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
