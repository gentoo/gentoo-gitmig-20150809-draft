# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyframer/pyframer-0.2.ebuild,v 1.6 2003/07/03 22:08:08 liquidx Exp $

inherit distutils

DESCRIPTION="Python interface for framerd"
SRC_URI="http://twistedmatrix.com/users/washort/pyframer/${P}.tar.gz"
HOMEPAGE="http://twistedmatrix.com/users/washort/pyframer/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/python
	>=dev-db/framerd-2.4.3"

DOCS="README.txt"
