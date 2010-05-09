# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/h5py/h5py-1.3.0.ebuild,v 1.1 2010/05/09 09:43:45 weaver Exp $

inherit distutils

DESCRIPTION="A simple Python interface to HDF5 files."
HOMEPAGE="http://h5py.alfven.org/"
SRC_URI="http://h5py.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sci-libs/hdf5-1.6.7
	dev-python/numpy"
RDEPEND="${DEPEND}"

src_test() {
	"${python}" setup.py test || die "test failed"
}
