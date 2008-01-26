# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/h5utils/h5utils-1.7.2.ebuild,v 1.5 2008/01/26 13:22:08 markusle Exp $

DESCRIPTION="utilities for visualization and conversion of scientific data in the HDF5 format"
SRC_URI="http://ab-initio.mit.edu/h5utils/${P}.tar.gz"
HOMEPAGE="http://ab-initio.mit.edu/h5utils/"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~amd64"

IUSE=""
SLOT="0"

DEPEND="sci-libs/hdf5"

src_compile() {
	econf --without-h5fromh4 || die
	emake || die
}

src_install() {
	einstall || die
	dodoc README NEWS AUTHORS
}
