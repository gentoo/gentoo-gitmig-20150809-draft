# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ttfquery/ttfquery-1.0.0.ebuild,v 1.4 2005/04/21 13:59:02 blubb Exp $

inherit distutils
MY_PN="TTFQuery"

DESCRIPTION="Font metadata and glyph outline extraction utility library"
HOMEPAGE="http://ttyquery.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64" # should work on all architectures

IUSE=""
DEPEND="virtual/python
	dev-python/fonttools
	dev-python/numeric"

S="${WORKDIR}/${MY_PN}-${PV}"
