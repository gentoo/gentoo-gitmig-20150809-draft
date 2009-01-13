# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-sensors/xfce4-sensors-0.10.99.6.ebuild,v 1.4 2009/01/13 15:39:12 ranger Exp $

inherit autotools eutils xfce44

xfce44

DESCRIPTION="acpi, lm_sensors and hddtemp panel plugin"
KEYWORDS="amd64 ppc ~x86"
IUSE="acpi debug hddtemp libnotify lm_sensors"

RDEPEND="libnotify? ( x11-libs/libnotify )
	lm_sensors? ( sys-apps/lm_sensors )
	hddtemp? ( app-admin/hddtemp )"
DEPEND="dev-util/intltool
	dev-util/xfce4-dev-tools"

pkg_setup() {
	XFCE_CONFIG+=" $(use_enable hddtemp) $(use_enable lm_sensors libsensors)
		$(use_enable acpi procacpi) $(use_enable acpi sysfsacpi)"

	if ! use hddtemp && ! use lm_sensors && ! use acpi; then
		XFCE_CONFIG+=" --enable-procacpi --enable-sysfsacpi"
		ewarn "Selecting ACPI for you, because you disabled all USE flags."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "/-no-undefined/d" src/Makefile.am || die "sed failed"
	AT_M4DIR="/usr/share/xfce4/dev-tools/m4macros/" eautoreconf
}

DOCS="AUTHORS ChangeLog NEWS NOTES README TODO"

xfce44_goodies_panel_plugin
