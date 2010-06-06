# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/scribes/scribes-0.3.3.3.ebuild,v 1.5 2010/06/06 11:28:04 ssuominen Exp $

EAPI=3

PYTHON_DEPEND="2:2.6"
GCONF_DEBUG=no

inherit autotools eutils gnome2 python

DESCRIPTION="a text editor that is simple, slim and sleek, yet powerful."
HOMEPAGE="http://scribes.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="gnome-base/gconf
	gnome-extra/yelp
	dev-libs/dbus-glib
	dev-python/dbus-python
	dev-python/gnome-python
	dev-python/gnome-python-extras
	dev-python/gnome-python-desktop"
DEPEND="${RDEPEND}
	app-text/gnome-doc-utils
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

DOCS="AUTHORS ChangeLog CONTRIBUTORS NEWS README TODO TRANSLATORS"

pkg_setup() {
	python_set_active_version 2
	G2CONF="--disable-scrollkeeper"
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-sandbox.patch
	eautoreconf

	ln -nfs $(type -P true) py-compile || die
	python_convert_shebangs -r 2 .

	gnome2_src_prepare
}

src_install() {
	gnome2_src_install
	find "${ED}" -name "*.py[co]" -exec rm -f {} +
}
