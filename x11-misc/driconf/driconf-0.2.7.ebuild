# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/driconf/driconf-0.2.7.ebuild,v 1.1 2005/09/09 03:03:31 joshuabaergen Exp $

inherit distutils

DESCRIPTION="driconf is a GTK+2 GUI configurator for DRI."
HOMEPAGE="http://dri.freedesktop.org/wiki/DriConf"
SRC_URI="http://freedesktop.org/~fxkuehl/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

IUSE=""
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=x11-libs/gtk+-2.4
	>=dev-lang/python-2.3
	dev-python/pygtk
	dev-python/pyxml
	|| ( x11-base/xorg-x11 x11-apps/xdriinfo)"

DOCS="CHANGELOG COPYING PKG-INFO README TODO"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix install locations which breaks location policy - Josh_B
	sed -i -e 's-/usr/local-/usr-g' driconf \
									   driconf.py \
									   setup.cfg \
									   setup.py \
									   || die "Sed failed!"
}

src_install() {
	distutils_src_install
}
