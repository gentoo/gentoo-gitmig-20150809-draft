# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/h5utils/h5utils-1.7.2.ebuild,v 1.6 2012/04/26 14:20:16 jlec Exp $

EAPI=4

DESCRIPTION="Utilities for visualization and conversion of scientific data in the HDF5 format"
SRC_URI="http://ab-initio.mit.edu/h5utils/${P}.tar.gz"
HOMEPAGE="http://ab-initio.mit.edu/h5utils/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 x86 ~ppc"
IUSE=""

DEPEND="sci-libs/hdf5"
RDEPEND="${DEPEND}"

src_configure() {
	econf --without-h5fromh4
}
