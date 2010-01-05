# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/price/price-0.9.1.ebuild,v 1.1 2010/01/05 10:52:52 voyageur Exp $

EAPI=2
inherit gnustep-2

MY_P=PRICE-${PV}
DESCRIPTION="Precision Raster Image Convolution Engine"
HOMEPAGE="http://price.sourceforge.net/"
SRC_URI="mirror://sourceforge/price/${MY_P}.tar.gz"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=gnustep-base/gnustep-gui-0.13.0"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	# Mixmatching #include and #import on limits.h leads to bug #278160
	sed -i -e 's/#import <limits.h>/#include <limits.h>/' *.m || die "sed failed"
}
