# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/matplotlib/matplotlib-0.73.1.ebuild,v 1.1 2005/03/22 15:51:44 fserb Exp $

inherit distutils virtualx

DESCRIPTION="matplotlib is a pure python plotting library designed to bring publication quality plotting to python with a syntax familiar to matlab users."
HOMEPAGE="http://matplotlib.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

IUSE="doc gtk"
SLOT="0"
KEYWORDS="~x86"
LICENSE="as-is"

DEPEND="virtual/python
		>=dev-python/numeric-22
		gtk? ( >=dev-python/pygtk-1.99.16 )"

src_compile() {
	export maketype="distutils_src_compile"
	virtualmake "$*"
}

src_install() {
	export maketype="distutils_src_install"
	virtualmake "$*"
	distutils_python_version

	if use doc ; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.py examples/README
		insinfo /usr/share/doc/${PF}/examples/data
		doins examples/data/*.dat
	fi
}

