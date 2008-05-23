# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/veusz/veusz-1.0-r1.ebuild,v 1.2 2008/05/23 21:06:10 maekke Exp $

inherit distutils

DESCRIPTION="Qt based scientific plotting package with good Postscript output."
HOMEPAGE="http://home.gna.org/veusz/"
SRC_URI="http://download.gna.org/${PN}/${P}.tar.gz"

IUSE="doc examples fits"
SLOT="0"
KEYWORDS="amd64 x86"
LICENSE="GPL-2"

DEPEND="dev-python/numpy"

RDEPEND="${DEPEND}
	>=dev-python/PyQt4-4.3
	fits? ( >=dev-python/pyfits-1.1 )"

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}
	if use doc; then
		doins -r examples || die "examples install failed"
	fi
	if use doc; then
		cd Documents
		doins -r Interface.txt manual.html manimages manual.pdf || die "doc install failed"
	fi
}
