# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-gnutls/python-gnutls-1.1.8.ebuild,v 1.1 2009/04/25 10:53:00 patrick Exp $

inherit distutils

DESCRIPTION="Python bindings for GnuTLS"
HOMEPAGE="http://ag-projects.com/"
SRC_URI="http://pypi.python.org/packages/source/p/python-gnutls/python-gnutls-1.1.8.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND="net-libs/gnutls"

src_install() {
	distutils_src_install

	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
