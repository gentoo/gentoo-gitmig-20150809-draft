# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py-xmlrpc/py-xmlrpc-0.8.8.3.ebuild,v 1.3 2004/06/02 21:31:02 kloeri Exp $

inherit distutils

IUSE=""
DESCRIPTION="Fast XML-RPC implementation for Python"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/py-xmlrpc/"
DEPEND="virtual/python"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~sparc alpha"

src_install () {
	mydoc="CHANGELOG COPYING INSTALL README"
	distutils_src_install
	insinto /usr/share/doc/${PF}/examples
	doins examples/*
	insinto /usr/share/doc/${PF}/examples/crj
	doins examples/crj/*
}

