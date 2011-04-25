# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/sensors-applet/sensors-applet-2.2.4.ebuild,v 1.8 2011/04/25 13:39:08 ssuominen Exp $

EAPI="2"

inherit gnome2

DESCRIPTION="GNOME panel applet to display readings from hardware sensors"
HOMEPAGE="http://sensors-applet.sourceforge.net/"
SRC_URI="mirror://sourceforge/sensors-applet/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86"
IUSE="hddtemp libnotify lm_sensors nvidia"

RDEPEND="
	>=dev-libs/glib-2.6:2
	>=x11-libs/gtk+-2.8.0:2
	|| ( gnome-base/gnome-panel[bonobo] <gnome-base/gnome-panel-2.32 )
	>=gnome-base/libgnome-2.8
	>=gnome-base/libgnomeui-2.8
	>=x11-libs/cairo-1.0.4
	hddtemp? ( >=app-admin/hddtemp-0.3_beta13 )
	libnotify? ( <x11-libs/libnotify-0.7 )
	lm_sensors? ( sys-apps/lm_sensors )
	nvidia? ( || (
		>=x11-drivers/nvidia-drivers-100.14.09
		media-video/nvidia-settings
	) )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12
	>=app-text/scrollkeeper-0.3.14
	>=app-text/gnome-doc-utils-0.3.2
	dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_with nvidia)
		$(use_with lm_sensors libsensors)
		$(use_enable libnotify)
		--disable-scrollkeeper
		--disable-static"
}
