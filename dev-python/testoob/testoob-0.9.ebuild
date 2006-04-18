# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/testoob/testoob-0.9.ebuild,v 1.3 2006/04/18 12:24:29 weeve Exp $

inherit distutils

DESCRIPTION="Advanced Python testing framework"
HOMEPAGE="http://testoob.sourceforge.net/"
SRC_URI="mirror://sourceforge/testoob/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~ia64 ~sparc ~x86"
IUSE="threads"

DEPEND="virtual/python"
RDEPEND="${DEPEND}
	dev-python/4suite
	threads? ( dev-python/twisted )"

DOCS="docs/*"
