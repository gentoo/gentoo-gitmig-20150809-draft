# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4/xfce4-4.1.99.3-r1.ebuild,v 1.1 2005/01/06 21:19:11 bcowan Exp $

DESCRIPTION="Xfce 4 base ebuild"
LICENSE="GPL-2 BSD LGPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

XFCE_RDEPEND=">=xfce-base/xfce-mcs-plugins-${PV}-r1
	>=xfce-base/xfce4-panel-${PV}-r1
	>=xfce-base/xfwm4-${PV}-r1
	>=xfce-base/xfce-utils-${PV}-r1
	>=xfce-base/xfdesktop-${PV}-r1
	>=xfce-base/xfce4-session-${PV}-r1
	>=xfce-base/xfprint-${PV}-r1
	>=xfce-extra/xfce4-iconbox-${PV}-r1
	>=xfce-extra/xfce4-systray-${PV}-r1
	>=xfce-extra/xfce4-toys-${PV}-r1
	>=xfce-extra/xfce4-trigger-launcher-${PV}-r1
	>=xfce-extra/xfwm4-themes-${PV}-r1
	>=xfce-extra/xfcalendar-${PV}-r1
	>=xfce-extra/xfce4-appfinder-${PV}-r1
	>=xfce-extra/xfce4-icon-theme-${PV}-r1
	>=xfce-base/xffm-${PV}-r1
	>=xfce-extra/xfce4-mixer-${PV}-r1"
XFCE_META=1

inherit xfce4