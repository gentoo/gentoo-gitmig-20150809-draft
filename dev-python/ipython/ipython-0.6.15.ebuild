# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ipython/ipython-0.6.15.ebuild,v 1.7 2007/09/19 23:42:25 hawking Exp $

inherit distutils

DESCRIPTION="An advanced interactive shell for Python."
HOMEPAGE="http://ipython.scipy.org/"
SRC_URI="http://ipython.scipy.org/dist/old/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc s390 x86"
IUSE="gnuplot"

DEPEND="virtual/python"
RDEPEND="${DEPEND}
	gnuplot? ( dev-python/gnuplot-py )"

DOCS="doc/ChangeLog"
