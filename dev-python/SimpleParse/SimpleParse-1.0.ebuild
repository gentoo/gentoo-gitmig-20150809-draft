# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/SimpleParse/SimpleParse-1.0.ebuild,v 1.12 2003/06/22 12:15:59 liquidx Exp $

IUSE=""

inherit distutils

S=${WORKDIR}/${P}
DESCRIPTION="A Parser Generator for mxTextTools."
SRC_URI="http://members.rogers.com/mcfletch/programming/simpleparse/${P}.zip"
HOMEPAGE="http://members.rogers.com/mcfletch/programming/simpleparse/simpleparse.html"
DEPEND="virtual/python
	dev-python/egenix-mx-base"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 sparc alpha"

src_install() {
	distutils_src_install --install-data=/usr/share/doc/${PF}
}
