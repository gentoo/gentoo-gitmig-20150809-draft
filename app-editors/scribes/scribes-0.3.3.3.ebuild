# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/scribes/scribes-0.3.3.3.ebuild,v 1.1 2008/01/13 18:37:48 drac Exp $

NEED_PYTHON=2.5

inherit gnome2 multilib python

DESCRIPTION="a text editor that is simple, slim and sleek, yet powerful."
HOMEPAGE="http://scribes.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
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
	sys-devel/gettext
	app-text/rarian"

DOCS="AUTHORS ChangeLog CONTRIBUTORS NEWS README TODO TRANSLATORS"

src_unpack() {
	gnome2_src_unpack
	find . -iname *.py[co] -exec rm -f {} \;
	rm -f compile.py py-compile
	touch compile.py py-compile
	fperms +x compile.py py-compile
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_version
	python_mod_optimize "${ROOT}"usr/$(get_libdir)/python${PYVER}/site-packages/SCRIBES
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup
}
