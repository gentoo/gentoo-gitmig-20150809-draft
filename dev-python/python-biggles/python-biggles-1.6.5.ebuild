# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-biggles/python-biggles-1.6.5.ebuild,v 1.1 2009/07/14 21:14:07 fauli Exp $

EAPI=2

inherit distutils

MY_P=${P/python/python2}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A Python module for creating publication-quality 2D scientific plots."
SRC_URI="mirror://sourceforge/biggles/${MY_P}.tar.gz"
HOMEPAGE="http://biggles.sourceforge.net/"

DEPEND="media-libs/plotutils[X]
	dev-python/numpy
	x11-libs/libSM
	x11-libs/libXext"
RDEPEND="${DEPEND}"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
LICENSE="GPL-2"

PYTHON_MODNAME=biggles

src_install() {
	distutils_src_install

	dodir /usr/share/doc/${PF}/examples
	cp -r examples/* "${D}/usr/share/doc/${PF}/examples"
}
