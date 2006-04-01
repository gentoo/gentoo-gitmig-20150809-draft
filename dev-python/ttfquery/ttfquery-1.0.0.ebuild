# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ttfquery/ttfquery-1.0.0.ebuild,v 1.6 2006/04/01 19:10:19 agriffis Exp $

inherit distutils
MY_PN="TTFQuery"

DESCRIPTION="Font metadata and glyph outline extraction utility library"
HOMEPAGE="http://ttfquery.sourceforge.net/"
SRC_URI="mirror://sourceforge/ttfquery/${MY_PN}-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86" # should work on all architectures

IUSE=""
DEPEND="virtual/python
	dev-python/fonttools
	dev-python/numeric"

S="${WORKDIR}/${MY_PN}-${PV}"
