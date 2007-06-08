# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-extras/xfce4-extras-4.4.0-r1.ebuild,v 1.7 2007/06/08 20:29:59 drac Exp $

DESCRIPTION="Meta ebuild for panel plugins and other extra applications"
HOMEPAGE="http://www.xfce.org/"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="~mips"
IUSE="battery lm_sensors wifi"

RDEPEND=">=xfce-base/xfce4-4.4
	>=xfce-extra/xfce4-clipman-0.8
	>=xfce-extra/xfce4-datetime-0.4
	>=xfce-extra/xfce4-dict-0.2.1
	>=xfce-extra/xfce4-mount-0.4.8
	>=xfce-extra/xfce4-notes-1.4.1
	>=xfce-extra/xfce4-quicklauncher-1.9.2
	>=xfce-extra/xfce4-screenshooter-1
	>=xfce-extra/xfce4-systemload-0.4.2
	>=xfce-extra/xfce4-weather-0.6
	>=xfce-extra/xfce4-xkb-0.4.3
	>=xfce-extra/xfce4-netload-0.4
	>=xfce-extra/xfce4-fsguard-0.3
	>=xfce-extra/xfce4-cpugraph-0.3
	>=xfce-extra/xfce4-taskmanager-0.3.2
	>=xfce-extra/xfce4-timer-0.5.1
	battery? ( >=xfce-extra/xfce4-battery-0.5 )
	wifi? ( >=xfce-extra/xfce4-wavelan-0.5.4 )
	lm_sensors? ( >=xfce-extra/xfce4-sensors-0.10.0 )"
