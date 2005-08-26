# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnome-python/gnome-python-2.10.0.ebuild,v 1.8 2005/08/26 13:19:12 agriffis Exp $

inherit gnome2 python eutils

DESCRIPTION="GNOME 2 bindings for Python"
HOMEPAGE="http://www.pygtk.org/"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="alpha amd64 ~ia64 ppc sparc x86"
IUSE="doc gtkhtml"

RDEPEND=">=dev-lang/python-2.2
	>=dev-python/pygtk-2.6
	>=dev-python/pyorbit-2.0.1
	>=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.6
	>=gnome-base/libgnome-2.8
	>=gnome-base/libgnomeui-2.8
	>=gnome-base/libgnomecanvas-2.8
	>=gnome-base/gnome-vfs-2.9
	>=gnome-base/gconf-2.9
	>=gnome-base/libbonobo-2.8
	>=gnome-base/libbonoboui-2.8
	>=gnome-base/libgnomeprintui-2.8
	gtkhtml? ( >=gnome-extra/libgtkhtml-3.2.5 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

# Skip test, to avoid gnome-python-2.0 block (fixes bug 72594)
RESTRICT="maketest"
DOCS="AUTHORS ChangeLog NEWS"

src_unpack() {
	unpack ${A}
	# disable pyc compiling
	mv ${S}/py-compile ${S}/py-compile.orig
	ln -s /bin/true ${S}/py-compile
}

src_install() {
	gnome2_src_install

	insinto /usr/share/doc/${P}
	doins -r examples

}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/lib/python${PYVER}/site-packages/gtk-2.0
}

pkg_postrm() {
	python_version
	python_mod_cleanup
}
