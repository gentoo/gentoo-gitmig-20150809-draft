# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/h5utils/h5utils-1.12.1-r1.ebuild,v 1.1 2011/08/25 15:57:24 xarthisius Exp $

EAPI=4

DESCRIPTION="utilities for visualization and conversion of HDF5 files"
HOMEPAGE="http://ab-initio.mit.edu/h5utils/"
SRC_URI="http://ab-initio.mit.edu/h5utils/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="octave"
SLOT="0"

DEPEND="sci-libs/hdf5"
RDEPEND="${DEPEND}"

src_configure() {
	econf $(use_with octave) --without-v5d
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc README NEWS AUTHORS
}
