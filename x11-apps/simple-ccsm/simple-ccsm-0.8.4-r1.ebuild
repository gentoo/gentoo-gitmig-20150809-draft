# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/simple-ccsm/simple-ccsm-0.8.4-r1.ebuild,v 1.1 2010/04/03 05:28:03 jmbsvicetto Exp $

inherit distutils gnome2-utils

DESCRIPTION="Simplified Compizconfig Settings Manager"
HOMEPAGE="http://www.compiz.org/"
SRC_URI="http://releases.compiz.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="gtk"

RDEPEND="
	>=dev-python/compizconfig-python-${PV}
	>=dev-python/pygtk-2.10
	>=x11-apps/ccsm-${PV}
"

src_compile() {
	distutils_src_compile --prefix=/usr
}

src_install() {
	distutils_src_install --prefix=/usr
}

pkg_postinst() {
	if use gtk; then
		gnome2_icon_savelist
		gnome2_icon_cache_update
	fi
}
