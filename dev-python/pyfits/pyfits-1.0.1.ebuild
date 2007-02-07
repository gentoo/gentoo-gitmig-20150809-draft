# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyfits/pyfits-1.0.1.ebuild,v 1.1 2007/02/07 11:18:26 bicatali Exp $

inherit distutils

DESCRIPTION="Provides an interface to FITS formatted files under python"
SRC_URI="ftp://ra.stsci.edu/pub/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.stsci.edu/resources/software_hardware/pyfits"

DEPEND=">=dev-lang/python-2.3
	dev-python/numarray"
IUSE="doc"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="AURA"

src_install() {
	distutils_src_install
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins docs/Users_Manual.pdf
	fi
}
