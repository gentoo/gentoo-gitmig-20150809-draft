# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/veusz/veusz-1.2.1.ebuild,v 1.1 2008/12/03 12:20:19 bicatali Exp $

inherit distutils

DESCRIPTION="Qt based scientific plotting package with good Postscript output"
HOMEPAGE="http://home.gna.org/veusz/"
SRC_URI="http://download.gna.org/${PN}/${P}.tar.gz"

IUSE="doc examples fits"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"

DEPEND="dev-python/numpy"

RDEPEND="${DEPEND}
	dev-python/PyQt4
	fits? ( dev-python/pyfits )"

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}
	if use examples; then
		doins -r examples || die "examples install failed"
	fi
	if use doc; then
		cd Documents
		doins -r Interface.txt manual.html manimages manual.pdf || die "doc install failed"
	fi
}
