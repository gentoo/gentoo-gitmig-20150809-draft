# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/meld3/meld3-0.6.6.ebuild,v 1.1 2010/03/04 16:10:39 djc Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="meld3 is an HTML/XML templating engine."
HOMEPAGE="http://dist.repoze.org/meld3/ http://pypi.python.org/pypi/meld3"
SRC_URI="http://dist.repoze.org/meld3/${P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

DOCS="CHANGES.txt COPYRIGHT.txt LICENSE.txt README.txt TODO.txt"

src_test() {
	cd meld3
	testing() {
		"$(PYTHON)" test_meld3.py
	}
	python_execute_function testing
}
