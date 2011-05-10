# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-sensors-plugin/xfce4-sensors-plugin-1.2.1.ebuild,v 1.2 2011/05/10 07:46:13 angelos Exp $

EAPI=4
EAUTORECONF=yes
inherit xfconf

DESCRIPTION="acpi, lm_sensors and hddtemp panel plugin"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/1.2/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+acpi debug hddtemp libnotify lm_sensors"

RDEPEND=">=x11-libs/gtk+-2.10:2
	>=xfce-base/libxfce4ui-4.6
	>=xfce-base/xfce4-panel-4.4
	libnotify? ( >=x11-libs/libnotify-0.4 )
	lm_sensors? ( >=sys-apps/lm_sensors-3.1.0 )
	hddtemp? ( app-admin/hddtemp net-analyzer/gnu-netcat )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

pkg_setup() {
	XFCONF=(
		--disable-static
		$(use_enable hddtemp)
		$(use_enable hddtemp netcat)
		$(use_enable lm_sensors libsensors)
		$(use_enable acpi procacpi)
		$(use_enable acpi sysfsacpi)
		$(use_enable libnotify notification)
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
	sed -i -e 's/^#elseif/#elif/' lib/sensors-interface.c || die
	sed -e 's/libxfcegui4/libxfce4ui/g' \
		-i src/actions.c -i src/callbacks.c -i src/interface.c \
		-i lib/sensors-interface.c || die
	xfconf_src_prepare
}
