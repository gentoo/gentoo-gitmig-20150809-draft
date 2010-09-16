# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/avant-window-navigator/avant-window-navigator-0.2.6-r1.ebuild,v 1.13 2010/09/16 01:51:47 ssuominen Exp $

inherit gnome2 python

DESCRIPTION="Fully customisable dock-like window navigator."
HOMEPAGE="http://launchpad.net/awn"
SRC_URI="http://launchpad.net/awn/${PV%.*}/${PV}/+download/${P}.tar.gz"
LICENSE="GPL-2 LGPL-2.1"

SLOT="0"
KEYWORDS="~amd64 ~x86"
# vala is not in tree yet
#IUSE="doc gnome vala xfce"
IUSE="doc gnome xfce"

# Replace gnome-vfs with gvfs when unmasked
#		gnome-base/gvfs

RDEPEND="
	|| (
		>=dev-lang/python-2.5
		dev-python/elementtree )
	>=dev-python/pygtk-2
	dev-python/pycairo
	dev-python/pyxdg
	gnome? (
		>=gnome-base/gconf-2
		>=gnome-base/gnome-desktop-2
		>=gnome-base/gnome-vfs-2
		>=gnome-base/libgnome-2
	)
	>=gnome-base/libglade-2
	>=dev-libs/glib-2.16.0
	dev-libs/dbus-glib
	xfce? ( || ( xfce-extra/thunar-vfs <xfce-base/thunar-1.1.0 ) )
	>=x11-libs/gtk+-2
	>=x11-libs/libwnck-2.20"

# vala is not in tree yet
#	vala? ( dev-lang/vala )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.35.5
	doc? ( >=dev-util/gtk-doc-1.4 )"

DOCS="AUTHORS Changelog NEWS README TODO"

src_unpack() {
	gnome2_src_unpack

	# Disable pyc compiling.
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile

	echo "awn-manager/awnLauncherEditor.py" >> po/POTFILES.in
	echo "awn-manager/launcher-editor.glade" >> po/POTFILES.in
	echo "data/awn.schemas.in" >> po/POTFILES.in
	echo "libawn/egg/eggdesktopfile.c" >> po/POTFILES.in
	echo "awn-manager/awnLauncherEditor.py" >> po/POTFILES.in
	echo "awn-manager/launcher-editor.glade" >> po/POTFILES.in
	echo "data/awn.schemas.in" >> po/POTFILES.in
	echo "libawn/egg/eggdesktopfile.c" >> po/POTFILES.in
}

src_compile() {
	local myconf

	if use gnome; then myconf="--with-desktop=gnome"
	elif use xfce; then myconf="--with-desktop=xfce4"
	else myconf="--with-desktop=agnostic"
	fi

	econf $(use_with gnome gconf) \
		$(use_enable doc gtk-doc) \
		--disable-vala \
		${myconf}
#		$(use_enable vala) \

	emake || die "emake failed"
}

pkg_postinst() {
	gnome2_pkg_postinst

	ewarn
	ewarn "AWN will be of no use if you do not have a compositing manager."

	python_mod_optimize $(python_get_sitedir)/awn
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup $(python_get_sitedir)/awn
}
