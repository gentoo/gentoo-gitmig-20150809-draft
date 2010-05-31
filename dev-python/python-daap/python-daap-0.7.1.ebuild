# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-daap/python-daap-0.7.1.ebuild,v 1.2 2010/05/31 18:33:57 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_P="PythonDaap-${PV}"

DESCRIPTION="PyDaap is a DAAP client implemented in Python, based on PyTunes"
HOMEPAGE="http://jerakeen.org/code/pythondaap"
SRC_URI="http://jerakeen.org/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="daap.py"

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
