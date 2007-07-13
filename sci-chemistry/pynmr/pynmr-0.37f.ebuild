# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/pynmr/pynmr-0.37f.ebuild,v 1.3 2007/07/13 05:48:10 mr_bones_ Exp $

inherit distutils

DESCRIPTION="An NMR Extension for PyMOL, written in Python"
HOMEPAGE="http://nmr.ulaval.ca/software/pynmr/"
SRC_URI="ftp://mesange.rsvs.ulaval.ca/software/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
IUSE=""
SLOT="0"
KEYWORDS="~x86"

DEPEND="<sci-chemistry/pymol-0.99"

src_install() {
	distutils_src_install
}
