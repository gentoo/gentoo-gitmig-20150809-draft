# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/SimpleParse/SimpleParse-1.0.ebuild,v 1.13 2004/03/28 10:32:10 kloeri Exp $

IUSE=""

inherit distutils

S=${WORKDIR}/${P}
DESCRIPTION="A Parser Generator for mxTextTools."
SRC_URI="mirror://sourceforge/simpleparse/${P}.zip"
HOMEPAGE="http://simpleparse.sourceforge.net"
DEPEND="virtual/python
	dev-python/egenix-mx-base"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 sparc alpha"

src_install() {
	distutils_src_install --install-data=/usr/share/doc/${PF}
}
