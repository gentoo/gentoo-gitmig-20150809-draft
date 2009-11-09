# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zdaemon/zdaemon-2.0.4.ebuild,v 1.2 2009/11/09 19:00:51 fauli Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Daemon process control library and tools for Unix-based systems"
HOMEPAGE="http://pypi.python.org/pypi/zdaemon"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-zope/zconfig"
DEPEND="${RDEPEND}
	dev-python/setuptools"
RESTRICT_PYTHON_ABIS="3.*"

DOCS="CHANGES.txt README.txt"

src_install() {
	distutils_src_install

	# Don't install tests.
	rm -fr "${D}"usr/$(get_libdir)/python*/site-packages/zdaemon/tests
}
