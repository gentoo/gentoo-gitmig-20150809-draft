# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/price/price-0.7.0.ebuild,v 1.1 2006/03/25 20:15:35 grobian Exp $

inherit gnustep

S=${WORKDIR}/PRICE-${PV}

DESCRIPTION="Precision Raster Image Convolution Engine"
HOMEPAGE="http://price.sourceforge.net/"
SRC_URI="mirror://sourceforge/price/PRICE-gs-${PV}.tar.gz"
KEYWORDS="~ppc ~x86"
SLOT="0"
LICENSE="GPL-2"

IUSE=""
DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}"

egnustep_install_domain "Local"
