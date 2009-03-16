# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/fisicalab/fisicalab-0.1.ebuild,v 1.1 2009/03/16 11:50:31 voyageur Exp $

inherit gnustep-2

DESCRIPTION="educational application to solve physics problems"
HOMEPAGE="http://www.nongnu.org/fisicalab"
SRC_URI="http://download.gna.org/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sci-libs/gsl-1.10
	>=virtual/gnustep-back-0.16.0"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}
