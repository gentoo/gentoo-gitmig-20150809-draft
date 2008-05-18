# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/avant-window-navigator/avant-window-navigator-0.2.6-r1.ebuild,v 1.6 2008/05/18 21:14:47 eva Exp $

inherit autotools gnome2 python

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

RDEPEND="dev-python/elementtree
	dev-python/pygtk
	dev-python/pycairo
	dev-python/pyxdg
	gnome? (
		gnome-base/gconf
		gnome-base/gnome-desktop
		gnome-base/gnome-vfs
		gnome-base/libgnome
	)
	gnome-base/libglade
	!gnome? ( !xfce? ( >=dev-libs/glib-2.15.0 ) )
	dev-libs/dbus-glib
	xfce? ( xfce-base/thunar )
	x11-libs/gtk+
	x11-libs/libwnck"

# vala is not in tree yet
#	vala? ( dev-lang/vala )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( dev-util/gtk-doc )"

DOCS="AUTHORS Changelog NEWS README TODO"

src_unpack() {
	gnome2_src_unpack

	# Disable pyc compiling.
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile
}

src_compile() {
	local myconf

	if use gnome; then myconf="--with-desktop=gnome"
	elif use xfce; then myconf="--with-desktop=xfce4"
	else myconf="--with-desktop=agnostic"
	fi

	econf $(use_enable gnome gconf ) \
		$(use_enable doc gtk-doc) \
		--disable-vala \
		${myconf} \
		|| die "econf failed"

#		$(use_enable vala) \

	emake || die "emake failed"
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_version
	python_mod_optimize "${ROOT}"/usr/$(get_libdir)/python${PYVER}/site-packages/awn
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_version
	python_mod_cleanup /usr/$(get_libdir)/python${PYVER}/site-packages/awn
}
