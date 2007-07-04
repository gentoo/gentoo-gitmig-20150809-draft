# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py-xmlrpc/py-xmlrpc-0.8.8.2.ebuild,v 1.15 2007/07/04 20:53:27 hawking Exp $

inherit distutils

IUSE=""
DESCRIPTION="Fast xml-rpc implementation for Python"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/py-xmlrpc/"

DEPEND="virtual/python"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 sparc alpha"

src_install () {
	distutils_src_install
	insinto /usr/share/doc/${PF}/examples
	doins examples/*
	insinto /usr/share/doc/${PF}/examples/crj
	doins examples/crj/*
}
