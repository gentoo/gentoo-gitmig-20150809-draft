# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py-xmlrpc/py-xmlrpc-0.8.8.3.ebuild,v 1.11 2006/10/09 19:19:49 tomk Exp $

inherit distutils

IUSE=""
DESCRIPTION="Fast XML-RPC implementation for Python"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/py-xmlrpc/"
DEPEND="virtual/python"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha ~amd64 ia64 ppc sparc x86"

src_install () {
	mydoc="CHANGELOG COPYING INSTALL README"
	distutils_src_install
	insinto /usr/share/doc/${PF}/examples
	doins examples/*
	insinto /usr/share/doc/${PF}/examples/crj
	doins examples/crj/*
}

