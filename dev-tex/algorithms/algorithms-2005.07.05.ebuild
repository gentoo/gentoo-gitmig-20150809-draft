# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/algorithms/algorithms-2005.07.05.ebuild,v 1.1 2006/01/20 11:15:40 ehmsen Exp $

inherit latex-package

DESCRIPTION="algorithms -- an environment for describing algorithms"
HOMEPAGE="http://algorithms.berlios.de/"
SRC_URI="http://download.berlios.de/algorithms/${P//\./-}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
# tetex-3.0 includes algorithms
DEPEND="!>=app-text/tetex-3.0"
S="${WORKDIR}/${PN}"

src_install() {
	latex-package_src_install || die
	dodoc README COPYING THANKS
}
