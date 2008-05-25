# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-fastcgi/python-fastcgi-1.1.ebuild,v 1.1 2008/05/25 16:32:09 chtekk Exp $

NEED_PYTHON=2.3

inherit distutils eutils

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Interface to OpenMarket's FastCGI C Library/SDK."
HOMEPAGE="http://pypi.python.org/pypi/${PN}/"
SRC_URI="http://cheeseshop.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND=">=dev-libs/fcgi-2.4.0-r2"
DEPEND="${RDEPEND}
		dev-python/setuptools"

src_unpack() {
	distutils_src_unpack

	epatch "${FILESDIR}"/${P}-setup.patch
}
