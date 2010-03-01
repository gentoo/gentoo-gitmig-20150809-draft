# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py-xmlrpc/py-xmlrpc-0.8.8.3-r1.ebuild,v 1.1 2010/03/01 23:46:49 neurogeek Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"
inherit distutils eutils

IUSE="examples"
DESCRIPTION="Fast XML-RPC implementation for Python"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/py-xmlrpc/"
DEPEND="virtual/python"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"

src_prepare() {

	#http://www.FreeBSD.org/cgi/cvsweb.cgi/ports/net/py-xmlrpc/files/
	epatch "${FILESDIR}/${PN}_patch-extra.patch"
	epatch "${FILESDIR}/${PN}_rpcBase64.patch"
	epatch "${FILESDIR}/${PN}_rpcClient.patch"
	epatch "${FILESDIR}/${PN}_rpcDate.patch"
	epatch "${FILESDIR}/${PN}_rpcDispatch.patch"
	epatch "${FILESDIR}/${PN}_rpcUtils.patch"
	epatch "${FILESDIR}/${PN}_rpcSource.patch"
	distutils_src_prepare

}

src_install () {
	distutils_src_install

	if use examples; then
		insinto "/usr/share/doc/${PF}/examples"
		doins examples/*
		insinto "/usr/share/doc/${PF}/examples/crj"
		doins examples/crj/*
	fi

}
