# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-extras/xfce4-extras-4.4.0.ebuild,v 1.7 2007/02/02 14:22:30 gustavoz Exp $

inherit xfce44

xfce44

DESCRIPTION="Xfce4 extras meta ebuild"
HOMEPAGE="http://www.xfce.org/"
LICENSE="GPL-2 BSD LGPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
SLOT="0"
IUSE="battery cpufreq gnome lm_sensors wlan"

RDEPEND=">=xfce-base/xfce4-${XFCE_MASTER_VERSION}
	>=xfce-extra/verve-0.3.5
	>=xfce-extra/xfce4-clipman-0.8
	>=xfce-extra/xfce4-datetime-0.4
	>=xfce-extra/xfce4-dict-0.2.1
	>=xfce-extra/xfce4-diskperf-2.1
	>=xfce-extra/xfce4-genmon-3.0-r1
	>=xfce-extra/xfce4-mailwatch-1.0.1
	>=xfce-extra/xfce4-mount-0.4.8
	>=xfce-extra/xfce4-notes-1.4.1
	>=xfce-extra/xfce4-quicklauncher-1.9.2
	>=xfce-extra/xfce4-screenshooter-1
	lm_sensors? ( >=xfce-extra/xfce4-sensors-0.10.0 )
	>=xfce-extra/xfce4-smartbookmark-0.4.2
	>=xfce-extra/xfce4-systemload-0.4.2
	>=xfce-extra/xfce4-weather-0.6
	gnome? ( >=xfce-extra/xfce4-xfapplet-0.1 )
	>=xfce-extra/xfce4-xkb-0.4.3
	>=xfce-extra/xfce4-netload-0.4
	>=xfce-extra/xfce4-fsguard-0.3
	>=xfce-extra/xfce4-cpugraph-0.3
	>=xfce-extra/xfce4-taskmanager-0.3.2
	>=xfce-extra/xfce4-timer-0.5.1
	battery? ( >=xfce-extra/xfce4-battery-0.5 )
	cpufreq? ( >=xfce-extra/xfce4-cpu-freq-0.0.1 )
	wlan? ( >=xfce-extra/xfce4-wavelan-0.5.4 )"

# hack to avoid exporting functions from eclass.
# we need eclass to get XFCE_MASTER_VERSION
src_compile() {
	echo
}

src_install() {
	echo
}
