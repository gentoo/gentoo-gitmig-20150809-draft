# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/h5py/h5py-1.2.1.ebuild,v 1.1 2009/09/21 04:25:26 bicatali Exp $

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
