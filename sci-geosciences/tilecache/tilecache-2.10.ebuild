# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/tilecache/tilecache-2.10.ebuild,v 1.1 2009/12/09 14:58:25 scarabeus Exp $

EAPI="2"

inherit distutils

DESCRIPTION="Web map tile caching system"
HOMEPAGE="http://tilecache.org/"
SRC_URI="http://${PN}.org/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/imaging"
RDEPEND="${DEPEND}"

src_install() {
	distutils_src_install "--debian"
}
