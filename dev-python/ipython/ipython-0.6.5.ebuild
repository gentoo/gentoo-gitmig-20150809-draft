# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ipython/ipython-0.6.5.ebuild,v 1.1 2004/12/04 23:58:40 kloeri Exp $

inherit distutils

DESCRIPTION="An advanced interactive shell for Python."
SRC_URI="http://ipython.scipy.org/dist/${P}.tar.gz"
HOMEPAGE="http://ipython.scipy.org/"
LICENSE="PYTHON"
SLOT="0"
IUSE="gnuplot"
KEYWORDS="~x86 ~amd64 ~ppc"
DEPEND="virtual/python"
RDEPEND="${DEPEND}
	gnuplot? ( dev-python/gnuplot-py )"

src_install() {
	distutils_src_install
	dodoc doc/ChangeLog
	mv ${D}/usr/share/doc/IPython/* ${D}/usr/share/doc/${PF}/
}
