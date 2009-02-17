# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/stiff/stiff-1.10.ebuild,v 1.1 2009/02/17 21:04:02 bicatali Exp $

DESCRIPTION="Converts astronomical FITS images to the TIFF format for illustration purposes."
HOMEPAGE="http://terapix.iap.fr/soft/stiff"
SRC_URI="ftp://ftp.iap.fr/pub/from_users/bertin/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"
DEPEND=""

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS BUGS ChangeLog HISTORY README THANKS
	use doc && dodoc doc/*
}
