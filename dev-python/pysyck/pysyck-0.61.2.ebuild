# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysyck/pysyck-0.61.2.ebuild,v 1.3 2007/10/16 01:09:40 sbriesen Exp $

NEED_PYTHON="2.3"

inherit distutils

MY_P="PySyck-${PV}"

DESCRIPTION="Python bindings for the Syck YAML parser and emitter"
HOMEPAGE="http://pyyaml.org/wiki/PySyck"
SRC_URI="http://pyyaml.org/download/pysyck/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-libs/syck-0.55"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="syck"

src_test() {
	PYTHONPATH=./lib/ "${python}" tests/test_syck.py
	einfo "Some tests may have failed due to pending bugs in dev-libs/syck"
}
