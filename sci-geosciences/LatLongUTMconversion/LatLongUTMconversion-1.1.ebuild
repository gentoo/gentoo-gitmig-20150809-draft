# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/LatLongUTMconversion/LatLongUTMconversion-1.1.ebuild,v 1.1 2005/05/22 06:43:13 nerdboy Exp $

inherit distutils eutils

DESCRIPTION="A lat/lon-UTM conversion utility (used by pygps)"
HOMEPAGE="http://www.pygps.org/#LatLongUTMconversion"
SRC_URI="http://www.pygps.org/${P}.tar.gz"

LICENSE="GPL-2"
IUSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~ppc64"

DEPEND="dev-lang/python"

src_compile() {
	distutils_src_compile
}

DOCS="README"

