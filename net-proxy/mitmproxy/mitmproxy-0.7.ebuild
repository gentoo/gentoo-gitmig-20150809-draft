# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/mitmproxy/mitmproxy-0.7.ebuild,v 1.1 2012/03/21 09:50:06 radhermit Exp $

EAPI="4"

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_MODNAME="libmproxy"

inherit distutils

DESCRIPTION="An interactive, SSL-capable, man-in-the-middle HTTP proxy"
HOMEPAGE="http://mitmproxy.org/ http://pypi.python.org/pypi/mitmproxy/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

RDEPEND="dev-libs/openssl
	>=dev-python/urwid-0.9.8"
DEPEND="${RDEPEND}"

src_install() {
	distutils_src_install

	use doc && dohtml -r doc/*
	use examples && dodoc -r examples
}
