# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-biggles/python-biggles-1.6.4.ebuild,v 1.1 2004/04/04 22:42:49 kloeri Exp $

inherit distutils

MY_P=${P/python/python2}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A Python module for creating publication-quality 2D scientific plots."
SRC_URI="mirror://sourceforge/biggles/${MY_P}.tar.gz"
HOMEPAGE="http://biggles.sourceforge.net"

DEPEND="~media-libs/plotutils-2.4.1
	dev-python/numeric"

IUSE=""
SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"

src_install() {
	distutils_src_install

	dodir /usr/share/doc/${PF}/examples
	cp -r examples/* ${D}/usr/share/doc/${PF}/examples
}
