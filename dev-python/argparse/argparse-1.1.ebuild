# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/argparse/argparse-1.1.ebuild,v 1.4 2010/04/22 12:02:43 djc Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Provides an easy, declarative interface for creating command line tools."
HOMEPAGE="http://code.google.com/p/argparse/ http://pypi.python.org/pypi/argparse"
SRC_URI="http://argparse.googlecode.com/files/${P}.zip"
LICENSE="Apache-2.0"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

PYTHON_MODNAME="argparse.py"

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test/test_argparse.py
	}
	python_execute_function testing
}
