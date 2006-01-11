# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ipython/ipython-0.7.0.ebuild,v 1.1 2006/01/11 17:50:42 marienz Exp $

inherit distutils

DESCRIPTION="An advanced interactive shell for Python."
HOMEPAGE="http://ipython.scipy.org/"
SRC_URI="http://ipython.scipy.org/dist/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ppc s390 x86"
IUSE="gnuplot"

DEPEND=">=virtual/python-2.3"
RDEPEND="${DEPEND}
	gnuplot? ( dev-python/gnuplot-py )"

DOCS="doc/ChangeLog"
