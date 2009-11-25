# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/morbid/morbid-0.8.6.1.ebuild,v 1.4 2009/11/25 09:51:11 maekke Exp $

inherit distutils

DESCRIPTION="A Twisted-based publish/subscribe messaging server that uses the STOMP protocol"
HOMEPAGE="http://pypi.python.org/pypi/morbid"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="dev-python/twisted"
DEPEND="${RDEPEND}
	dev-python/setuptools"
