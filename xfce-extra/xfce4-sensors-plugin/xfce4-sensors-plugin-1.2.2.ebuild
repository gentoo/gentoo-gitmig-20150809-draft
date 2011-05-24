# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-sensors-plugin/xfce4-sensors-plugin-1.2.2.ebuild,v 1.1 2011/05/24 07:40:30 angelos Exp $

EAPI=4
EAUTORECONF=yes
inherit xfconf

DESCRIPTION="acpi, lm_sensors and hddtemp panel plugin"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/1.2/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+acpi debug hddtemp libnotify lm_sensors nvidia"

RDEPEND=">=x11-libs/gtk+-2.10:2
	>=xfce-base/libxfce4ui-4.6
	>=xfce-base/xfce4-panel-4.4
	hddtemp? ( app-admin/hddtemp net-analyzer/gnu-netcat )
	libnotify? ( >=x11-libs/libnotify-0.4 )
	lm_sensors? ( >=sys-apps/lm_sensors-3.1.0 )
	nvidia? ( media-video/nvidia-settings )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

pkg_setup() {
	XFCONF=(
		--disable-static
		$(use_enable acpi procacpi)
		$(use_enable acpi sysfsacpi)
		$(use_enable hddtemp netcat)
		$(use_enable hddtemp)
		$(use_enable libnotify notification)
		$(use_enable lm_sensors libsensors)
		$(use_enable nvidia xnvctrl)
		$(xfconf_use_debug)
		)

	if ! use hddtemp && ! use lm_sensors && ! use acpi; then
		XFCONF+=(
			--enable-procacpi
			--enable-sysfsacpi
			)
	fi

	DOCS=( AUTHORS ChangeLog NEWS NOTES README TODO )
}

src_prepare() {
	sed -i -e '/-no-undefined/d' src/Makefile.am || die
	xfconf_src_prepare
}
