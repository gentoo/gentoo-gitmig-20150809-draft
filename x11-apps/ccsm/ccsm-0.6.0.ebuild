# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/ccsm/ccsm-0.6.0.ebuild,v 1.2 2007/10/24 17:45:21 lu_zero Exp $

DESCRIPTION="Compizconfig Settings Manager"
HOMEPAGE="http://compiz-fusion.org"
SRC_URI="http://releases.compiz-fusion.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="dev-python/compizconfig-python
	>=dev-python/pygtk-2.10"

S="${WORKDIR}/${P}"

src_compile() {
	./setup.py build --prefix=/usr || die "build failed"
}

src_install() {
	./setup.py install --root="${D}" --prefix=/usr || die "install failed"
	dodoc AUTHORS PKG-INFO || die "dodoc failed"
}
