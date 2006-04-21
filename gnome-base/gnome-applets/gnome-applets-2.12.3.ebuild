# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-applets/gnome-applets-2.12.3.ebuild,v 1.9 2006/04/21 20:41:26 tcort Exp $

inherit eutils gnome2

DESCRIPTION="Applets for the GNOME Desktop and Panel"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
SLOT="2"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="acpi apm hal ipv6"

RDEPEND=">=x11-libs/gtk+-2.5
	>=dev-libs/glib-2.5
	>=gnome-base/libgnome-2.8
	>=gnome-base/libgnomeui-2.8
	>=gnome-base/gnome-vfs-2.8
	>=gnome-base/gconf-2.8
	>=gnome-base/gnome-panel-2.9.4
	>=gnome-base/libgtop-2.11.92
	>=gnome-base/libglade-2.4
	>=gnome-base/gail-1.1
	>=x11-libs/libxklavier-1.13
	>=x11-libs/libwnck-2.9.3
	>=app-admin/system-tools-backends-1.1.3
	>=gnome-base/gnome-desktop-2.11.1
	hal? ( >=sys-apps/hal-0.5.3
		>=sys-apps/dbus-0.34 )
	=media-libs/gstreamer-0.8*
	=media-libs/gst-plugins-0.8*
	>=gnome-extra/gucharmap-1.4
	apm? ( sys-apps/apmd )
	acpi? ( sys-power/acpid )"

DEPEND="${RDEPEND}
	dev-libs/libxslt
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.28
	>=app-text/scrollkeeper-0.1.4
	>=app-text/gnome-doc-utils-0.3.2
	~app-text/docbook-xml-dtd-4.3"

DOCS="AUTHORS ChangeLog NEWS README"
USE_DESTDIR="1"

MAKEOPTS="${MAKEOPTS} -j1"


pkg_setup() {
	G2CONF="--disable-scrollkeeper \
		--enable-flags \
		$(use_enable ipv6)
		$(use_with hal)"

	if ! use apm && ! use acpi; then
		G2CONF="${G2CONF} --disable-battstat"
	fi
}

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# add hal configure switch
	epatch ${FILESDIR}/${PN}-2.12.1-hal-switch.patch

	autoconf || die "autoconf failed"
}

src_install() {
	gnome2_src_install

	for applet in \
	accessx-status battstat charpick cpufreq drivemount geyes gkb-new  \
	gswitchit gtik gweather mini-commander mixer modemlights multiload \
	null_applet stickynotes trashapplet; do

		docinto ${applet}

		for d in AUTHORS ChangeLog NEWS README README.themes TODO; do
			[ -s ${applet}/${d} ] && dodoc ${applet}/${d}
		done

	done
}
