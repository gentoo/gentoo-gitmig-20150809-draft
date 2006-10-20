# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/control-center/control-center-2.14.2.ebuild,v 1.11 2006/10/20 17:11:52 agriffis Exp $

inherit eutils gnome2 autotools

DESCRIPTION="The gnome2 Desktop configuration tool"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86"
IUSE="alsa eds gstreamer"

RDEPEND=">=gnome-base/gnome-vfs-2.2
	>=media-libs/fontconfig-1
	virtual/xft
	|| ( (
		x11-libs/libXdmcp
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libXxf86misc
		x11-libs/libXau )
	virtual/x11 )
	>=x11-libs/gtk+-2.8.12
	>=dev-libs/glib-2.8
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
	>=gnome-base/libgnome-2.2
	media-libs/freetype
	>=gnome-base/orbit-2.12.4
	eds? ( >=gnome-extra/evolution-data-server-1.3 )
	!arm? ( alsa? ( >=media-libs/alsa-lib-0.9 ) )
	gstreamer? ( >=media-libs/gst-plugins-base-0.10 )"

DEPEND="${RDEPEND}
	|| ( (
		x11-libs/libxkbfile
		x11-proto/kbproto
		x11-proto/xf86miscproto
		x11-proto/scrnsaverproto )
	virtual/x11 )
	app-text/scrollkeeper
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.34.2
	>=app-text/gnome-doc-utils-0.3.2
	dev-util/desktop-file-utils"

DOCS="AUTHORS ChangeLog NEWS README TODO"

MAKEOPTS="${MAKEOPTS} -j1"

pkg_setup() {
	G2CONF="${G2CONF} --disable-schemas-install \
		--disable-scrollkeeper  \
		--enable-vfs-methods    \
		$(use_enable alsa)      \
		$(use_enable eds aboutme)"

	if use gstreamer ; then
		G2CONF="${G2CONF} --enable-gstreamer=0.10"
	else
		G2CONF="${G2CONF} --enable-gstreamer=no"
	fi
}

src_unpack() {
	gnome2_src_unpack

	# Temporary workaround for a problematic behaviour with acme.
	epatch ${FILESDIR}/${PN}-2.6.0-remove-pmu.patch

	# Gentoo-specific support for xcursor themes. See bug #103638.
	epatch ${FILESDIR}/${PN}-2.11-gentoo_xcursor.patch

	# Disable the master pty check, as it causes sandbox violations
	epatch ${FILESDIR}/${PN}-2.13.5-disable-master-pty.patch

	# fix for hardcoded paths for bzip2 / tar in gnome-theme-installer
	epatch "${FILESDIR}"/${PN}-2.14.1-path-fix.patch

	eautoreconf
	intltoolize --force || die
}
