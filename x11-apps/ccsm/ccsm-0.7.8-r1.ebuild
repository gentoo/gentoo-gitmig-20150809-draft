# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/ccsm/ccsm-0.7.8-r1.ebuild,v 1.1 2008/10/27 22:32:29 jmbsvicetto Exp $

inherit distutils

DESCRIPTION="Compizconfig Settings Manager"
HOMEPAGE="http://compiz-fusion.org"
SRC_URI="http://releases.compiz-fusion.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="~dev-python/compizconfig-python-${PV}
	>=dev-python/pygtk-2.10"

DOCS="AUTHORS PKG-INFO"

src_compile() {
	distutils_src_compile --prefix=/usr
}

src_install() {
	distutils_src_install --prefix=/usr
}
