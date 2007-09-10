# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/price/price-0.8.1.ebuild,v 1.1 2007/09/10 18:55:31 voyageur Exp $

inherit gnustep-2

DESCRIPTION="Precision Raster Image Convolution Engine"
HOMEPAGE="http://price.sourceforge.net/"
SRC_URI="mirror://sourceforge/price/PRICE-${PV}.tar.gz"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="GPL-2"

S=${WORKDIR}/PRICE

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i -e "s/GNUSTEP_INSTALLATION_DIR.*//" GNUmakefile
}
