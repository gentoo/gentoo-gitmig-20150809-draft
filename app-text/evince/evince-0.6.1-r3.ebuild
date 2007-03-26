# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/evince/evince-0.6.1-r3.ebuild,v 1.1 2007/03/26 19:57:06 dang Exp $

inherit eutils gnome2 autotools

DESCRIPTION="Simple document viewer for GNOME"
HOMEPAGE="http://www.gnome.org/projects/evince/"
LICENSE="GPL-2"

IUSE="dbus djvu doc dvi gnome t1lib tiff"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"

RDEPEND="
	dvi? (
		virtual/tetex
		t1lib? ( >=media-libs/t1lib-5.0.0 )
	)
	dbus? ( || ( >=dev-libs/dbus-glib-0.71
		( <sys-apps/dbus-0.90 >=sys-apps/dbus-0.33 ) ) )
	tiff? ( >=media-libs/tiff-3.6 )
	>=app-text/poppler-bindings-0.5.4
	>=dev-libs/glib-2
	>=gnome-base/gnome-vfs-2.0
	>=gnome-base/libglade-2
	>=gnome-base/gconf-2
	gnome-base/libgnome
	>=gnome-base/libgnomeprintui-2.6
	>=gnome-base/libgnomeui-2.14
	gnome? ( >=gnome-base/nautilus-2.10 )
	>=x11-libs/gtk+-2.8.15
	gnome-base/gnome-keyring
	djvu? ( >=app-text/djvu-3.5.17 )
	virtual/ghostscript"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=app-text/gnome-doc-utils-0.3.2
	>=dev-util/pkgconfig-0.9
	>=sys-devel/automake-1.9
	>=dev-util/intltool-0.35"


DOCS="AUTHORS ChangeLog NEWS README TODO"
USE_DESTDIR="1"
ELTCONF="--portage"


pkg_setup() {
	G2CONF="--disable-scrollkeeper \
		--enable-comics		\
		--enable-impress	\
		--with-print=gnome	\
		$(use_enable dbus)  \
		$(use_enable djvu)  \
		$(use_enable dvi)   \
		$(use_enable t1lib) \
		$(use_enable tiff)  \
		$(use_enable gnome nautilus)"

	if ! built_with_use app-text/poppler-bindings gtk; then
		einfo "Please re-emerge app-text/poppler-bindings with the gtk USE flag set"
		die "poppler-bindings needs gtk flag set"
	fi
}

src_unpack(){
	unpack "${A}"
	cd "${S}"

	# Fix .desktop file so menu item shows up
	epatch ${FILESDIR}/${PN}-0.5.3-display-menu.patch

	# Make dbus actually switchable
	epatch ${FILESDIR}/${P}-dbus-switch.patch

	# Limits on gv buffer lengths.  Bug #156573
	epatch "${FILESDIR}"/${P}-gv-limit.patch

	eautoreconf
}
