# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/morbid/morbid-0.8.4.ebuild,v 1.1 2009/04/19 12:22:25 caleb Exp $

inherit distutils

DESCRIPTION="A Twisted-based publish/subscribe messaging server that uses the STOMP protocol"
HOMEPAGE="http://pypi.python.org/pypi/morbid/0.8.4"
SRC_URI="http://pypi.python.org/packages/source/m/morbid/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="dev-python/twisted"
DEPEND="${RDEPEND}
	dev-python/setuptools"

src_install() {
	distutils_src_install
}

