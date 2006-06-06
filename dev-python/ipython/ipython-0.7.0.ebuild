# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ipython/ipython-0.7.0.ebuild,v 1.3 2006/06/06 22:35:51 carlo Exp $

NEED_PYTHON=2.3

inherit distutils

DESCRIPTION="An advanced interactive shell for Python."
HOMEPAGE="http://ipython.scipy.org/"
SRC_URI="http://ipython.scipy.org/dist/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~s390 ~x86"
IUSE="gnuplot"

RDEPEND="gnuplot? ( dev-python/gnuplot-py )"

DOCS="doc/ChangeLog"
