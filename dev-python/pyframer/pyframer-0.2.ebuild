# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyframer/pyframer-0.2.ebuild,v 1.10 2004/06/25 01:39:09 agriffis Exp $

inherit distutils

DESCRIPTION="Python interface for framerd"
HOMEPAGE="http://twistedmatrix.com/users/washort/pyframer/"
SRC_URI="http://twistedmatrix.com/users/washort/pyframer/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/python
	>=dev-db/framerd-2.4.3"

DOCS="README.txt"
