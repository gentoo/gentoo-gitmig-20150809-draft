# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ipython/ipython-0.6.6.ebuild,v 1.2 2005/01/25 22:46:16 lucass Exp $

inherit distutils

DESCRIPTION="An advanced interactive shell for Python."
SRC_URI="http://ipython.scipy.org/dist/${P}.tar.gz"
HOMEPAGE="http://ipython.scipy.org/"
LICENSE="PYTHON"
SLOT="0"
IUSE="gnuplot"
KEYWORDS="x86 ~amd64 ~ppc"
DEPEND="virtual/python"
RDEPEND="${DEPEND}
		gnuplot? ( dev-python/gnuplot-py )"
DOCS="doc/ChangeLog"
