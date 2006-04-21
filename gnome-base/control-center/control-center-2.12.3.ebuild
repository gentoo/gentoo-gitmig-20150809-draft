# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/control-center/control-center-2.12.3.ebuild,v 1.10 2006/04/21 20:30:37 tcort Exp $

inherit eutils gnome2 autotools

DESCRIPTION="The gnome2 Desktop configuration tool"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="alsa eds gstreamer"

RDEPEND=">=gnome-base/gnome-vfs-2.2
	>=media-libs/fontconfig-1
	virtual/xft
	|| ( (	x11-libs/libXxf86misc
		x11-apps/xinit
		x11-apps/xset )
	 virtual/x11 )
	>=x11-libs/gtk+-2.6
	>=gnome-base/libbonobo-2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/nautilus-2.6
	>=gnome-base/gconf-2
	>=gnome-base/libglade-2
	>=gnome-base/libbonoboui-2.2
	>=gnome-base/gnome-desktop-2.2
	>=gnome-base/gnome-menus-2.11.1
	media-sound/esound
	>=x11-wm/metacity-2.8.6-r1
	>=x11-libs/libxklavier-1.14
	>=dev-libs/glib-2.5
	>=gnome-base/libgnome-2.2
	media-libs/freetype
	>=gnome-base/orbit-2.12.4
	eds? ( >=gnome-extra/evolution-data-server-1.3 )
	!arm? ( alsa? ( >=media-libs/alsa-lib-0.9 ) )
	gstreamer? ( =media-libs/gst-plugins-0.8* )"

DEPEND="${RDEPEND}
	|| ( (
		x11-libs/libxkbfile
		x11-proto/xf86miscproto
		x11-proto/scrnsaverproto )
	virtual/x11 )
	app-text/scrollkeeper
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.28
	>=app-text/gnome-doc-utils-0.3.2
	dev-util/desktop-file-utils"

DOCS="AUTHORS ChangeLog NEWS README TODO"
USE_DESTDIR="1"

MAKEOPTS="${MAKEOPTS} -j1"


pkg_setup() {
	G2CONF="--disable-schemas-install \
		--disable-scrollkeeper  \
		--enable-vfs-methods    \
		$(use_enable alsa)      \
		$(use_enable gstreamer) \
		$(use_enable eds aboutme)"
}

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# Temporary workaround for a problematic behaviour with acme.
	epatch ${FILESDIR}/${PN}-2.6.0-remove-pmu.patch

	# Fix the logout keyboard shortcut by moving it out of
	# the control-center here, and into metacity, bug #52034
	epatch ${FILESDIR}/${PN}-2.9-logout.patch

	# Fix the hardcoding of tar, bzip2, and gzip paths in
	# gnome-theme-installer.  bug #84977
	epatch ${FILESDIR}/${PN}-2.12.2-pathfix.patch

	# Gentoo-specific support for xcursor themes. See bug #103638.
	epatch ${FILESDIR}/${PN}-2.11-gentoo_xcursor.patch

	# Fix for -Wextra gcc error #114533
	epatch ${FILESDIR}/${PN}-2.12.2-gcc-Wextra.patch

	aclocal || die
	_elibtoolize --force --copy || die
	eautoheader || die
	eautomake || die
	intltoolize --force || die
	eautoconf || die
}
