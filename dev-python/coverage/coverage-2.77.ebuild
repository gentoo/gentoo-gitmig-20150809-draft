# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/coverage/coverage-2.77.ebuild,v 1.1 2007/12/18 07:33:18 robbat2 Exp $

inherit distutils

DESCRIPTION="Coverage.py is a Python module that measures code coverage during Python execution."
HOMEPAGE="http://nedbatchelder.com/code/modules/coverage.html"
SRC_URI="http://nedbatchelder.com/code/modules/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc ~x86 ~amd64"
IUSE=""

src_install() {
	distutils_src_install
	# Rename the runner so that it is not found in sys.path
	# by the Python search routines. The script would take care of this itself
	# normally, but for usage with dev-python/nose, we need to handle it.
	mv "${D}"/usr/bin/coverage{.py,}
}
