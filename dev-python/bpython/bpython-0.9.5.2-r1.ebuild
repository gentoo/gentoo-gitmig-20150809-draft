# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/bpython/bpython-0.9.5.2-r1.ebuild,v 1.2 2009/11/28 18:45:41 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"
PYTHON_USE_WITH="ncurses"

inherit distutils eutils

DESCRIPTION="Syntax highlighting and autocompletion for the Python interpreter"
HOMEPAGE="http://www.bpython-interpreter.org/ http://pypi.python.org/pypi/bpython"
SRC_URI="http://www.bpython-interpreter.org/releases/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pygments
	dev-python/setuptools"
RDEPEND="${DEPEND}"

DOCS="sample-config sample.theme light.theme"

src_prepare() {
	epatch "${FILESDIR}/${P}-python-3.patch"
}

distutils_src_install_post_hook() {
	mv "${D}usr/bin/bpython" "${D}usr/bin/bpython-${PYTHON_ABI}"
}
