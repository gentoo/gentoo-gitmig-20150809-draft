# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-sensors/xfce4-sensors-0.10.0-r1.ebuild,v 1.4 2007/05/19 15:17:49 welp Exp $

inherit xfce44

xfce44

DESCRIPTION="lm_sensors and hddtemp panel plugin"
KEYWORDS="amd64 ~ppc x86"
IUSE="debug hddtemp"

RDEPEND="sys-apps/lm_sensors
	hddtemp? ( app-admin/hddtemp )"
DEPEND="dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_unpack() {
	unpack ${A}
	sed -i -e 's:hddtemp -n:/usr/sbin/hddtemp -n:g' "${S}"/panel-plugin/sensors.c
}

pkg_postinst() {
	xfce44_pkg_postinst

	if use hddtemp; then
		[[ -u "${ROOT}"/usr/sbin/hddtemp ]] || \
		elog "You need to run \"chmod u+s /usr/sbin/hddtemp\" to show disk temperatures."
	fi
}

xfce44_goodies_panel_plugin
