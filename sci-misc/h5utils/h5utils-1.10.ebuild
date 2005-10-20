# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/h5utils/h5utils-1.10.ebuild,v 1.1 2005/10/20 01:00:30 ribosome Exp $

inherit eutils autotools

DESCRIPTION="utilities for visualization and conversion of scientific data in the HDF5 format"
SRC_URI="http://ab-initio.mit.edu/h5utils/${P}.tar.gz"
HOMEPAGE="http://ab-initio.mit.edu/h5utils/"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

IUSE=""
SLOT="0"

DEPEND="sci-libs/hdf5"

src_compile() {
	eautoconf
	econf --without-octave --without-h5fromh4 || die
	emake || die
}

src_install() {
	einstall || die
	dodoc README COPYING NEWS AUTHORS
}
