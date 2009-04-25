# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/simple-ccsm/simple-ccsm-0.8.2.ebuild,v 1.2 2009/04/25 15:32:56 ranger Exp $

inherit gnome2-utils

DESCRIPTION="Simplified Compizconfig Settings Manager"
HOMEPAGE="http://www.compiz.org/"
SRC_URI="http://releases.compiz.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="gtk"

DEPEND="~dev-python/compizconfig-python-${PV}
	>=dev-python/pygtk-2.10
	~x11-apps/ccsm-${PV}"
RDEPEND="${DEPEND}"

src_compile() {
	./setup.py build --prefix=/usr
}

src_install() {
	./setup.py install --root="${D}" --prefix=/usr
}

pkg_postinst() {
	use gtk && gnome2_icon_cache_update
}
