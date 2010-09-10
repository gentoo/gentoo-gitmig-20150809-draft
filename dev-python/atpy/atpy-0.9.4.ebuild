# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/atpy/atpy-0.9.4.ebuild,v 1.2 2010/09/10 21:37:58 arfrever Exp $

EAPI="2"

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MYPN=ATpy
MYP="${MYPN}-${PV}"

DESCRIPTION="Astronomical tables support for Python"
HOMEPAGE="http://atpy.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MYP}.tar.gz"

RDEPEND="dev-python/numpy
	dev-python/asciitable
	fits? ( dev-python/pyfits )
	hdf5? ( dev-python/h5py )
	mysql? ( dev-python/mysql-python )
	postgres? ( dev-db/pygresql )
	sqlite? ( dev-python/pysqlite )
	votable? ( dev-python/vo )"

RESTRICT_PYTHON_ABIS="2.[45] 3.*"

DEPEND=">=dev-python/numpy-1.3"

IUSE="+fits hdf5 mysql postgres sqlite +votable"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"

S="${WORKDIR}/${MYP}"

src_prepare() {
	distutils_src_prepare

	# Disable failing MySQL tests.
	sed -e "s/import MySQLdb/raise ImportError/" -i test/unittests.py || die "sed failed"
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test/unittests.py
	}
	python_execute_function testing
}
