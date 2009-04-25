# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/ccsm/ccsm-0.8.2.ebuild,v 1.2 2009/04/25 15:33:13 ranger Exp $

inherit distutils

DESCRIPTION="Compizconfig Settings Manager"
HOMEPAGE="http://www.compiz.org/"
SRC_URI="http://releases.compiz.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

DEPEND="~dev-python/compizconfig-python-${PV}
	>=dev-python/pygtk-2.12
	gnome-base/librsvg
"
RDEPEND="${DEPEND}"

DOCS="AUTHORS PKG-INFO"

src_compile() {
	distutils_src_compile --prefix=/usr
}

src_install() {
	distutils_src_install --prefix=/usr
}
