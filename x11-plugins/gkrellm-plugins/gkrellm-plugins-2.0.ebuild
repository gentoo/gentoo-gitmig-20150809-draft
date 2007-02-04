# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-plugins/gkrellm-plugins-2.0.ebuild,v 1.1 2007/02/04 17:06:12 masterdriverz Exp $

DESCRIPTION="Meta package for gkrellm plugins"
HOMEPAGE="http://www.gkrellm.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc sparc x86"
#IUSE="audacious"
IUSE=""

RDEPEND="!<app-admin/gkrellm-2
		!x11-plugins/gkrellm-bfm
		!x11-plugins/gkrellm-console
		!x11-plugins/gkrellm-gnome
		!x11-plugins/gkrellm-logwatch
		!x11-plugins/gkrellm-sensors
		!x11-plugins/gkrellmouse
		!x11-plugins/gkrellmwho
		!<x11-plugins/gkrellmwireless-2.0.2
		!<x11-plugins/gkrellmms-2.1.22-r1
		!<x11-plugins/gkrellm-bgchanger-0.0.8
		>=x11-plugins/gkrellaclock-0.3.2
		x11-plugins/gkrellflynn
		>=x11-plugins/gkrellkam-2.0.0
		>=x11-plugins/gkrellm-hddtemp-0.2_beta
		>=x11-plugins/gkrellm-leds-0.8.0
		>=x11-plugins/gkrellm-mailwatch-2.4.2
		>=x11-plugins/gkrellm-radio-2.0.3-r1
		>=x11-plugins/gkrellm-reminder-2.0.0
		>=x11-plugins/gkrellm-volume-2.1.4
		>=x11-plugins/gkrellmitime-1.0
		>=x11-plugins/gkrellmlaunch-0.5
		>=x11-plugins/gkrellmoon-0.6
		>=x11-plugins/gkrellshoot-0.4.1
		>=x11-plugins/gkrellstock-0.5
		>=x11-plugins/gkrellsun-0.12.2
		x11-plugins/gkrelltop
		>=x11-plugins/gkrellweather-2.0.6"

		#|| ( >=x11-plugins/gkrellmwireless-2.0.2 x11-plugins/gkrellm-wifi )
		#audacious? ( >=x11-plugins/gkrellmms-2.1.22-r1 )
		#>=x11-plugins/gkrellm-bgchanger-0.0.8
		#x11-plugins/gkrellm-countdown
		#x11-plugins/gkrellm-gamma
		#x11-plugins/gkrellm-trayicons
		#x11-plugins/gkrellmbups"
