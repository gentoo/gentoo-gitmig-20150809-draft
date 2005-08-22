# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-applets/gnome-applets-2.10.1.ebuild,v 1.9 2005/08/22 12:28:00 flameeyes Exp $

inherit gnome2 eutils

DESCRIPTION="Applets for the Gnome2 Desktop and Panel"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 FDL-1.1"
SLOT="2"
KEYWORDS="~alpha amd64 hppa ~ia64 ~mips ppc ~ppc64 sparc x86"
IUSE="doc apm acpi ipv6 gstreamer"

RDEPEND=">=x11-libs/gtk+-2.5
	>=dev-libs/glib-2.5
	>=gnome-base/libgnome-2.8
	>=gnome-base/libgnomeui-2.8
	>=gnome-base/gnome-vfs-2.8
	>=gnome-base/gconf-2.8
	>=gnome-base/gnome-panel-2.9.4
	>=gnome-base/libgtop-2.9.4
	>=gnome-base/libglade-2.4
	>=gnome-base/gail-1.3
	>=x11-libs/libxklavier-1.13
	>=x11-libs/libwnck-2.9.3
	>=app-admin/system-tools-backends-1.1.3
	dev-libs/libxslt
	kernel_linux? (
		apm? ( sys-apps/apmd )
		acpi? ( sys-power/acpid )
	)
	gstreamer? ( >=media-libs/gstreamer-0.8.2 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12
	>=app-text/scrollkeeper-0.3.11
	doc? ( dev-util/gtk-doc )"

DOCS="AUTHORS ChangeLog NEWS README"

G2CONF="${G2CONF} $(use_enable ipv6) $(use_enable gstreamer) --enable-flags"

MAKEOPTS="${MAKEOPTS} -j1"

USE_DESTDIR="1"

src_unpack() {

	unpack ${A}
	gnome2_omf_fix

}

src_install() {

	gnome2_src_install

	for APPLET in accessx-status battstat \
				  charpick cpufreq drivemount \
				  geyes gkb-new gswitchit \
				  gtik gweather \
				  mini-commander mixer modemlights multiload \
				  null_applet stickynotes trashapplet; do
			docinto ${APPLET}
			dodoc ${APPLET}/{ChangeLog,AUTHORS,NEWS,TODO} ${APPLET}/README*
	done

}
