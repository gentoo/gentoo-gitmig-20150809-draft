# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-sensors/xfce4-sensors-0.10.99.2.ebuild,v 1.3 2007/12/09 20:46:22 dertobi123 Exp $

inherit xfce44

xfce44

DESCRIPTION="lm_sensors and hddtemp panel plugin"
KEYWORDS="amd64 ppc x86"
IUSE="debug hddtemp lm_sensors"

RDEPEND="lm_sensors? ( sys-apps/lm_sensors )
	hddtemp? ( app-admin/hddtemp )"
DEPEND="dev-util/intltool"

pkg_setup() {
	if ! use hddtemp && ! use lm_sensors ; then
		ewarn
		ewarn "You did not define any sensors. You have to specify"
		ewarn "USE=hddtemp, USE=lm_sensors or both"
		ewarn
	fi

	# We need this since the build system disables hddtemp/lm_sensors even if we
	# use --enable them
	use hddtemp || XFCE_CONFIG="${XFCE_CONFIG} --disable-hddtemp"
	use lm_sensors || XFCE_CONFIG="${XFCE_CONFIG} --disable-libsensors"
}

pkg_postinst() {
	xfce44_pkg_postinst

	if use hddtemp; then
		[ -u "${ROOT}"/usr/sbin/hddtemp ] || \
		elog "You need to run \"chmod u+s /usr/sbin/hddtemp\" to show disk temperatures."
	fi
}

DOCS="AUTHORS ChangeLog NEWS NOTES README TODO"

xfce44_goodies_panel_plugin
