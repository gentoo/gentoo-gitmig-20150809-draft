# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/numarray/numarray-1.1.1.ebuild,v 1.1 2004/12/07 00:04:17 carlo Exp $

inherit distutils

DESCRIPTION="Numarray is an array processing package designed to efficiently manipulate large multi-dimensional arrays"
SRC_URI="mirror://sourceforge/numpy/${P}.tar.gz"
HOMEPAGE="http://www.stsci.edu/resources/software_hardware/numarray"
DEPEND=">=dev-lang/python-2.2.2"
IUSE=""
SLOT="0"
KEYWORDS="~x86 ~ppc ~s390"
LICENSE="BSD"

src_install() {
	distutils_src_install
	dodoc Doc/*.txt LICENSE.txt
	cp -r Doc/*.py Doc/manual Doc/release_notes Examples ${D}/usr/share/doc/${PF}
}

