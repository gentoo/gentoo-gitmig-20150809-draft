# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/qbzr/qbzr-0.9.7.ebuild,v 1.1 2009/02/09 14:37:10 pva Exp $

NEED_PYTHON=2.4

inherit distutils versionator

DESCRIPTION="Qt frontend for Bazaar"
HOMEPAGE="https://launchpad.net/qbzr"
SRC_URI="http://launchpad.net/qbzr/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-util/bzr-1.3
		>=dev-python/PyQt4-4.1"

DOCS="AUTHORS.txt COPYING.txt NEWS.txt README.txt TODO.txt"

S=${WORKDIR}/${PN}

PYTHON_MODNAME=bzrlib

src_test() {
	elog "It's impossible to run tests at this point. If you wish to run tests"
	elog "after installation of ${PN} execute:"
	elog " $ bzr selftest -s bzrlib.plugins.qbzr"
}
