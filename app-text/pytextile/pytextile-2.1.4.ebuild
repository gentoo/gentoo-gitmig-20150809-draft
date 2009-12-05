# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pytextile/pytextile-2.1.4.ebuild,v 1.1 2009/12/05 16:35:09 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"
NEED_PYTHON="2.5"

inherit distutils

MY_PN="textile"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A Python implementation of Textile, Dean Allen's Human Text Generator. Textile simplifies the work of creating (X)HTML."
HOMEPAGE="http://pypi.python.org/pypi/textile"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="test"

DEPEND="test? ( dev-python/nose )"
RDEPEND=""
RESTRICT_PYTHON_ABIS="2.4 3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="${MY_PN}"

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" nosetests-${PYTHON_ABI}
	}
	python_execute_function testing
}
