# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygoogle/pygoogle-0.6.ebuild,v 1.3 2005/02/21 20:59:29 blubb Exp $

inherit distutils

DESCRIPTION="A Python wrapper for the Google web API"
SRC_URI="mirror://sourceforge/pygoogle/${P}.tar.gz"
HOMEPAGE="http://pygoogle.sourceforge.net/"

IUSE=""
SLOT="0"
LICENSE="PYTHON"
KEYWORDS="~x86 ~ppc-macos ~amd64"

DEPEND="virtual/python"

src_install() {
	distutils_src_install
	cd doc && dohtml -r * && cd ..
	dodoc readme.txt
}
