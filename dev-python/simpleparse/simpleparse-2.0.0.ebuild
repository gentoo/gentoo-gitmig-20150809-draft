# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/simpleparse/simpleparse-2.0.0.ebuild,v 1.9 2005/08/26 03:46:13 agriffis Exp $

IUSE=""

inherit distutils

MY_P="SimpleParse-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="A Parser Generator for mxTextTools."
SRC_URI="mirror://sourceforge/simpleparse/${MY_P}.zip"
HOMEPAGE="http://simpleparse.sourceforge.net"
DEPEND="virtual/python
	dev-python/egenix-mx-base
	app-arch/unzip"
LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 ~ia64 ~ppc sparc x86"

src_install() {
	distutils_src_install --install-data=/usr/share/doc/${PF}
}
