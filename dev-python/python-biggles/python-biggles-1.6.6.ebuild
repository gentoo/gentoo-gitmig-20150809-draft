# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-biggles/python-biggles-1.6.6.ebuild,v 1.2 2010/09/17 10:19:02 fauli Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_PN="python2-biggles"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A Python module for creating publication-quality 2D scientific plots"
HOMEPAGE="http://biggles.sourceforge.net/"
SRC_URI="mirror://sourceforge/biggles/${MY_P}.tar.gz"

DEPEND="dev-python/numpy
	media-libs/plotutils[X]
	x11-libs/libSM
	x11-libs/libXext"
RDEPEND="${DEPEND}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="biggles"

src_install() {
	distutils_src_install

	dodir /usr/share/doc/${PF}/examples
	cp -r examples/* "${ED}usr/share/doc/${PF}/examples"
}
