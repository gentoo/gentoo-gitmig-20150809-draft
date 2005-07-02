# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/matplotlib/matplotlib-0.82.ebuild,v 1.1 2005/07/02 15:51:39 fserb Exp $

inherit distutils

DESCRIPTION="matplotlib is a pure python plotting library designed to bring publication quality plotting to python with a syntax familiar to matlab users."
HOMEPAGE="http://matplotlib.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

IUSE="doc gtk"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="as-is"

DEPEND="virtual/python
		|| (
		>=dev-python/numeric-22
		dev-python/numarray
		)
		>=media-libs/freetype-2.1.7
		media-libs/libpng
		sys-libs/zlib
		gtk? ( >=dev-python/pygtk-1.99.16 )"

src_unpack() {
	unpack ${A}
	cd ${S}

	# This would blow things up if we had a
	# dev-python/pytz or dev-python/dateutil
	# Those should be added as dependencies
	sed -i -e "151,+6d;158a\            add_dateutil()" setup.py
}

src_install() {
	distutils_src_install

	if use doc ; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.py examples/README
		insinfo /usr/share/doc/${PF}/examples/data
		doins examples/data/*.dat
	fi
}

