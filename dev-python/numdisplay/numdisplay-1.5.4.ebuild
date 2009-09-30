# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/numdisplay/numdisplay-1.5.4.ebuild,v 1.1 2009/09/30 19:28:06 bicatali Exp $

inherit distutils eutils

DESCRIPTION="Python package for interactively displaying FITS arrays"
SRC_URI="http://stsdas.stsci.edu/${PN}/download/${P}.tar.gz"
HOMEPAGE="http://stsdas.stsci.edu/numdisplay/"

SLOT="0"

KEYWORDS="~amd64 ~x86"
LICENSE="AURA"
IUSE=""

DEPEND=""
RDEPEND="dev-python/numpy"

S="${WORKDIR}/${PN}"

src_install() {
	distutils_src_install
	rm -f "${D}"usr/$(get_libdir)/python*/site-packages/${PN}/LICENSE.txt
}
