# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/paisley/paisley-0.1.ebuild,v 1.3 2009/11/30 18:20:43 djc Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Paisley is a CouchDB client written in Python to be used within a Twisted application."
HOMEPAGE="http://launchpad.net/paisley"
SRC_URI="http://pypi.python.org/packages/source/p/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/twisted"
RESTRICT_PYTHON_ABIS="3.*"

src_test() {
	python test_paisley.py
}
