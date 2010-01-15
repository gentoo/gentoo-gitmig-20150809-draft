# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/numdisplay/numdisplay-1.5.6.ebuild,v 1.1 2010/01/15 19:11:52 bicatali Exp $

inherit distutils

DESCRIPTION="Python package for interactively displaying FITS arrays"
SRC_URI="http://stsdas.stsci.edu/${PN}/download/${P}.tar.gz"
HOMEPAGE="http://stsdas.stsci.edu/numdisplay/"

SLOT="0"

KEYWORDS="~amd64 ~x86"
LICENSE="BSD"
IUSE=""

DEPEND=""
RDEPEND="dev-python/numpy"

S="${WORKDIR}/${PN}"

src_install() {
	distutils_src_install
	rm -f "${D}"usr/$(get_libdir)/python*/site-packages/${PN}/LICENSE.txt
}
