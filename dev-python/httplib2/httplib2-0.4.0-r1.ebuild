# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/httplib2/httplib2-0.4.0-r1.ebuild,v 1.2 2009/05/14 19:48:24 maekke Exp $

NEED_PYTHON=2.3

inherit distutils

DESCRIPTION="A comprehensive HTTP client library with caching and authentication."
HOMEPAGE="http://code.google.com/p/httplib2/"
SRC_URI="http://httplib2.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"

IUSE=""

src_unpack() {
	distutils_src_unpack
	epatch "${FILESDIR}"/compat-2.6-${PV}.patch
}
