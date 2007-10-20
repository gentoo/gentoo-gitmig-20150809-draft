# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-sensors/xfce4-sensors-0.10.99_p1.ebuild,v 1.1 2007/10/20 19:10:06 angelos Exp $

inherit xfce44

MY_PV=${PV/_p/-}
MY_P=${PN}-plugin-${MY_PV}

xfce44

DESCRIPTION="lm_sensors and hddtemp panel plugin"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug hddtemp"

RDEPEND="sys-apps/lm_sensors
	hddtemp? ( app-admin/hddtemp )"
DEPEND="dev-util/intltool"

pkg_postinst() {
	xfce44_pkg_postinst

	if use hddtemp; then
		[ -u "${ROOT}"/usr/sbin/hddtemp ] || \
		elog "You need to run \"chmod u+s /usr/sbin/hddtemp\" to show disk temperatures."
	fi
}

DOCS="AUTHORS ChangeLog NEWS NOTES README TODO"

xfce44_goodies_panel_plugin
