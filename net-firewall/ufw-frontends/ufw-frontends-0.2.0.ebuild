# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ufw-frontends/ufw-frontends-0.2.0.ebuild,v 1.1 2011/07/28 07:20:19 pva Exp $

EAPI=3
PYTHON_DEPEND="2:2.6"
inherit distutils

DESCRIPTION="Provides graphical frontend to ufw"
HOMEPAGE="http://code.google.com/p/ufw-frontends/"
SRC_URI="http://ufw-frontends.googlecode.com/files/${P}.tar.gz"

# CC* is for a png file
LICENSE="GPL-3 CCPL-Attribution-ShareAlike-NonCommercial-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/pygobject
	dev-python/pygtk
	net-firewall/ufw
	x11-libs/gksu"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	sed -i 's/^Exec=su-to-root -X -c/Exec=gksu/' \
		share/ufw-gtk.desktop || die
	# Qt version is unusable for now
	rm gfw/frontend_qt.py || die
	distutils_src_prepare
}
