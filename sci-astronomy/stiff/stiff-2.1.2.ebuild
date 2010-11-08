# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/stiff/stiff-2.1.2.ebuild,v 1.2 2010/11/08 17:08:39 xarthisius Exp $

EAPI=2

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
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS BUGS ChangeLog HISTORY README THANKS
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins doc/*.pdf || die
	fi
}
