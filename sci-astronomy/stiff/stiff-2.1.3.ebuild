# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/stiff/stiff-2.1.3.ebuild,v 1.1 2011/04/10 14:45:35 bicatali Exp $

EAPI=4

DESCRIPTION="Converts astronomical FITS images to the TIFF format"
HOMEPAGE="http://astromatic.iap.fr/software/stiff"
SRC_URI="ftp://ftp.iap.fr/pub/from_users/bertin/${PN}/${P}.tar.gz"

LICENSE="CeCILL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc threads"

RDEPEND="media-libs/tiff
	virtual/jpeg
	sys-libs/zlib"
DEPEND="${RDEPEND}"

src_configure() {
	econf $(use_enable threads)
}

src_install () {
	default
	use doc && dodoc doc/*.pdf
}
