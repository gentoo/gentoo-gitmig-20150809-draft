# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-sensors-plugin/xfce4-sensors-plugin-1.2.3.ebuild,v 1.8 2012/05/05 07:26:09 mgorny Exp $

EAPI=4
EAUTORECONF=yes
inherit xfconf

DESCRIPTION="acpi, lm_sensors and hddtemp panel plugin"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/1.2/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="+acpi debug hddtemp libnotify lm_sensors video_cards_nvidia"

REQUIRED_USE="|| ( hddtemp lm_sensors acpi )"

RDEPEND=">=x11-libs/gtk+-2.10:2
	>=xfce-base/libxfce4ui-4.6
	>=xfce-base/xfce4-panel-4.4
	hddtemp? ( app-admin/hddtemp net-analyzer/gnu-netcat )
	libnotify? ( >=x11-libs/libnotify-0.4 )
	lm_sensors? ( >=sys-apps/lm_sensors-3.1.0 )
	video_cards_nvidia? ( media-video/nvidia-settings )"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig"

pkg_setup() {
	XFCONF=(
		--disable-static
		$(use_enable acpi procacpi)
		$(use_enable acpi sysfsacpi)
		$(use_enable hddtemp netcat)
		$(use_enable hddtemp)
		$(use_enable libnotify notification)
		$(use_enable lm_sensors libsensors)
		$(use_enable video_cards_nvidia xnvctrl)
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS ChangeLog NEWS NOTES README TODO )
}

src_prepare() {
	sed -i -e '/-no-undefined/d' src/Makefile.am || die
	# Use flags from xfce4-dev-tools instead of defining them again in
	# configure.in wrt #386979
	sed -i -e '/PLATFORM_CFLAGS/s:-Werror::' configure.in || die
	# http://bugzilla.xfce.org/show_bug.cgi?id=8057
	# value "Monitor" in key "Categories" in group "Desktop Entry" requires
	# another category to be present among the following categories: System
	sed -i -e 's:Monitor:System;&:' src/xfce4-sensors.desktop.in || die
	xfconf_src_prepare
}
