# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ipython/ipython-0.6.12.ebuild,v 1.2 2005/03/29 02:06:13 vapier Exp $

inherit distutils

DESCRIPTION="An advanced interactive shell for Python."
HOMEPAGE="http://ipython.scipy.org/"
SRC_URI="http://ipython.scipy.org/dist/${P}.tar.gz"

LICENSE="PYTHON"
SLOT="0"
KEYWORDS="~amd64 ~ppc s390 ~x86"
IUSE="gnuplot"

DEPEND="virtual/python"
RDEPEND="${DEPEND}
	gnuplot? ( dev-python/gnuplot-py )"

DOCS="doc/ChangeLog"
