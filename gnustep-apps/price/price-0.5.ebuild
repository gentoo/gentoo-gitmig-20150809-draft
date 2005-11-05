# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/price/price-0.5.ebuild,v 1.3 2005/11/05 08:19:15 halcy0n Exp $

inherit gnustep

S=${WORKDIR}/PRICE-gs-pc4

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
