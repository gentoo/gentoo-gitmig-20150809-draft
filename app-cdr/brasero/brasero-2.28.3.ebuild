# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/brasero/brasero-2.28.3.ebuild,v 1.1 2009/12/23 04:18:28 nirbheek Exp $

EAPI=2
GCONF_DEBUG=no
inherit gnome2 multilib

DESCRIPTION="Brasero (aka Bonfire) is yet another application to burn CD/DVD for the gnome desktop."
HOMEPAGE="http://www.gnome.org/projects/brasero"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="beagle +cdr +css +libburn totem nautilus test"

CDEPEND=">=dev-libs/glib-2.15.6:2
	>=x11-libs/gtk+-2.16:2
	>=gnome-base/gconf-2
	>=media-libs/gstreamer-0.10.15
	>=media-libs/gst-plugins-base-0.10
	>=dev-libs/libxml2-2.6
	>=dev-libs/libunique-1
	>=dev-libs/dbus-glib-0.7.2
	totem? ( >=dev-libs/totem-pl-parser-2.22 )
	beagle? ( >=dev-libs/libbeagle-0.3 )
	libburn? ( >=dev-libs/libburn-0.4
		>=dev-libs/libisofs-0.6.4 )
	nautilus? ( >=gnome-base/nautilus-2.22.2 )"
RDEPEND="${CDEPEND}
	sys-apps/hal
	app-cdr/dvd+rw-tools
	app-cdr/cdrdao
	css? ( media-libs/libdvdcss )
	cdr? ( virtual/cdrtools )
	!libburn? ( virtual/cdrtools )
	media-plugins/gst-plugins-meta"
DEPEND="${CDEPEND}
	app-text/gnome-doc-utils
	dev-util/pkgconfig
	sys-devel/gettext
	dev-util/intltool
	test? ( app-text/docbook-xml-dtd:4.3 )"

pkg_setup() {
	G2CONF="--disable-dependency-tracking
		--disable-scrollkeeper
		$(use_enable nautilus)
		$(use_enable libburn libburnia)
		$(use_enable cdr cdrtools)
		$(use_enable cdr cdrkit)
		$(use_enable beagle search)
		$(use_enable totem playlist)
		--disable-caches"

	if ! use libburn; then
		G2CONF="${G2CONF} --enable-cdrtools --enable-cdrkit"
	fi

	DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"
}

src_install() {
	gnome2_src_install

	# Remove useless .la files
	rm -f "${D}"/usr/$(get_libdir)/brasero/plugins/*.la
	rm -f "${D}"/usr/$(get_libdir)/nautilus/extensions-2.0/*.la
}
