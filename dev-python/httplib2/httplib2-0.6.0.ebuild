# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/httplib2/httplib2-0.6.0.ebuild,v 1.2 2010/02/10 04:25:57 josejx Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="A comprehensive HTTP client library"
HOMEPAGE="http://code.google.com/p/httplib2/ http://pypi.python.org/pypi/httplib2"
SRC_URI="http://httplib2.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	distutils_src_install

	dodoc README
	newdoc python3/README README-python3
}
