# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/price/price-0.8.2.ebuild,v 1.1 2008/02/21 09:39:33 voyageur Exp $

inherit gnustep-2

MY_P=PRICE-${PV}
DESCRIPTION="Precision Raster Image Convolution Engine"
HOMEPAGE="http://price.sourceforge.net/"
SRC_URI="mirror://sourceforge/price/${MY_P}.tar.gz"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="GPL-2"

S=${WORKDIR}/${MY_P}
