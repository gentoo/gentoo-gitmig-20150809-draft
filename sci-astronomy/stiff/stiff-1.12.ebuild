# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/stiff/stiff-1.12.ebuild,v 1.3 2009/07/28 17:42:50 bicatali Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="Converts astronomical FITS images to the TIFF format"
HOMEPAGE="http://astromatic.iap.fr/software/stiff"
SRC_URI="ftp://ftp.iap.fr/pub/from_users/bertin/${PN}/${P}.tar.gz"

LICENSE="CeCILL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-configure.patch
	eautoreconf
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS BUGS ChangeLog HISTORY README THANKS
	use doc && dodoc doc/*
}
