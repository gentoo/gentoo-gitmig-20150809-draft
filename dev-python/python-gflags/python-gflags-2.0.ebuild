# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-gflags/python-gflags-2.0.ebuild,v 1.2 2012/03/26 16:28:01 nelchael Exp $

EAPI="4"

PYTHON_COMPAT="python2_5 python2_6 python2_7 pypy1_7 pypy1_8"

inherit python-distutils-ng

DESCRIPTION="Google's Python argument parsing library."
HOMEPAGE="http://code.google.com/p/python-gflags/"
SRC_URI="http://python-gflags.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

python_prepare_all() {
	sed \
		-e 's/data_files=\[("bin", \["gflags2man.py"\])\]/scripts=\["gflags2man.py"\]/' \
		-i setup.py || die "sed failed"
}
