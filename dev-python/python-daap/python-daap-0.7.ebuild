# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-daap/python-daap-0.7.ebuild,v 1.1 2007/07/08 18:07:50 drac Exp $

inherit distutils python

MY_P="PythonDaap-${PV}"

DESCRIPTION="PyDaap is a DAAP client implemented in Python, based on PyTunes"
HOMEPAGE="http://jerakeen.org/code/pythondaap"
SRC_URI="http://jerakeen.org/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="examples"

DEPEND=">=dev-lang/python-2.4"

S="${WORKDIR}"/${MY_P}

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}

pkg_postinst() {
	python_version
	python_mod_optimize "${ROOT}"/usr/lib*/python${PYVER}/site-packages
}

pkg_postrm() {
	python_version
	python_mod_cleanup "${ROOT}"/usr/lib*/python${PYVER}/site-packages
}
