# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ipython/ipython-0.6.0.ebuild,v 1.4 2005/01/25 22:46:16 lucass Exp $

inherit distutils

MY_P=${P/ipython/IPython}
DESCRIPTION="An advanced interactive shell for Python."
SRC_URI="http://ipython.scipy.org/dist/${MY_P}.tar.gz"
HOMEPAGE="http://ipython.scipy.org/"
LICENSE="PYTHON"
SLOT="0"
IUSE="gnuplot"
KEYWORDS="x86 ~amd64 ~ppc"
DEPEND=">=dev-lang/python-2.2"
RDEPEND="${DEPEND}
	gnuplot? ( dev-python/gnuplot-py )"

S="${WORKDIR}/${MY_P}"

src_install() {
	distutils_src_install
	dodoc doc/ChangeLog
	mv ${D}/usr/share/doc/IPython/* ${D}/usr/share/doc/${PF}/
}

