# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/pynmr/pynmr-0.32_alpha.ebuild,v 1.2 2005/04/04 19:38:42 ribosome Exp $

inherit distutils

DESCRIPTION="An NMR Extension for PyMOL, written in Python"
HOMEPAGE="http://rmn.ulaval.ca/labo/software/pynmr.html"
SRC_URI="ftp://mesange.rsvs.ulaval.ca/software/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

IUSE=""
SLOT="0"
KEYWORDS="~x86"

DEPEND="sci-chemistry/pymol"

src_install() {
	distutils_src_install
}
