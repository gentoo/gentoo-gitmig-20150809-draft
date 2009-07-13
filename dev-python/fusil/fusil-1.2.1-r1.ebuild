# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fusil/fusil-1.2.1-r1.ebuild,v 1.1 2009/07/13 22:03:19 neurogeek Exp $

EAPI="2"
NEED_PYTHON=2.4

inherit distutils

DESCRIPTION="Fusil the fuzzer is a Python library used to write fuzzing programs."
HOMEPAGE="http://fusil.hachoir.org/"
SRC_URI="http://pypi.python.org/packages/source/f/fusil/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

DEPEND="|| ( ( =dev-lang/python-2.4* dev-python/ctypes ) >=dev-lang/python-2.5 )"
RDEPEND="dev-python/python-ptrace"

PYTHON_MODNAME="fusil"

src_install(){
	distutils_src_install

	if use doc; then
		DOCS="doc/*"
	fi

	if use examples; then
		insinto "/usr/share/doc/${PF}"
		doins -r examples
	fi

}

pkg_postinst() {
	enewgroup fusil
	enewuser fusil -1 -1 -1 "fusil"
}
