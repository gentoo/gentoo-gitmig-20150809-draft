# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/matplotlib/matplotlib-0.87.7.ebuild,v 1.1 2006/11/29 01:01:55 marienz Exp $

NEED_PYTHON=2.3

inherit distutils python

DESCRIPTION="matplotlib is a pure python plotting library designed to bring publication quality plotting to python with a syntax familiar to matlab users."
HOMEPAGE="http://matplotlib.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

IUSE="doc gtk tk"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="PYTHON"

DEPEND="|| (
		>=dev-python/numeric-23
		dev-python/numarray
		dev-python/numpy
	)
	>=media-libs/freetype-2.1.7
	media-libs/libpng
	sys-libs/zlib
	gtk? ( >=dev-python/pygtk-2.2 )
	dev-python/pytz
	dev-python/python-dateutil"


pkg_setup() {
	if use tk; then
		python_tkinter_exists
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# disable autodetection, rely on USE instead
	epatch "${FILESDIR}/${PN}-0.87.7-no-autodetect.patch"
	sed -i \
		-e "/^BUILD_GTK/s/'auto'/$(use gtk && echo 1 || echo 0)/" \
		-e "/^BUILD_WX/s/'auto'/0/" \
		-e "/^BUILD_TK/s/'auto'/$(use tk && echo 1 || echo 0)/" \
		setup.py
}

src_install() {
	distutils_src_install

	if use doc ; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.py examples/README
		insinto /usr/share/doc/${PF}/examples/data
		doins examples/data/*.dat
	fi
}
