# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/tilecache/tilecache-2.10.ebuild,v 1.2 2010/04/06 08:24:44 scarabeus Exp $

EAPI="2"

inherit distutils

DESCRIPTION="Web map tile caching system"
HOMEPAGE="http://tilecache.org/"
SRC_URI="http://${PN}.org/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/imaging"
DEPEND="${RDEPEND}
	dev-python/setuptools
"

src_install() {
	distutils_src_install "--debian"
}
