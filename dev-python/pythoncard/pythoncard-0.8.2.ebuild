# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pythoncard/pythoncard-0.8.2.ebuild,v 1.4 2011/01/01 19:40:45 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

MY_P="PythonCard-${PV}"

DESCRIPTION="Cross-platform GUI construction kit for python"
HOMEPAGE="http://pythoncard.sourceforge.net/index.html"
SRC_URI="mirror://sourceforge/pythoncard/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="=dev-python/wxpython-2.6*"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"
PYTHON_MODNAME="PythonCard"

src_compile() {
	:
}

src_install() {
	distutils_src_install

	# install-pythoncard.py is only for Windows.
	rm -f "${ED}usr/bin/install-pythoncard.py"

	dohtml -r docs/html/*
	dodoc docs/*.txt
}

pkg_postinst() {
	python_mod_optimize -x "/(docs|samples|tools)/" PythonCard
}
