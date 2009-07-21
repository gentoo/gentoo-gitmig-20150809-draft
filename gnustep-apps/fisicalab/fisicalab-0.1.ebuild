# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/fisicalab/fisicalab-0.1.ebuild,v 1.2 2009/07/21 12:18:26 voyageur Exp $

EAPI=2
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

src_prepare() {
	epatch "${FILESDIR}"/${P}-as-needed.patch

}
