# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/h5utils/h5utils-1.12.1.ebuild,v 1.1 2009/08/04 05:53:45 spock Exp $

inherit eutils autotools

DESCRIPTION="utilities for visualization and conversion of scientific data in the HDF5 format"
SRC_URI="http://ab-initio.mit.edu/h5utils/${P}.tar.gz"
HOMEPAGE="http://ab-initio.mit.edu/h5utils/"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"

IUSE="octave"
SLOT="0"

DEPEND="sci-libs/hdf5"

src_compile() {
	econf $(use_with octave) || die
	emake || die
}

src_install() {
	einstall || die
	dodoc README NEWS AUTHORS
}
