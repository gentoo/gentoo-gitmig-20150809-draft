# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4/xfce4-4.2.1.1.ebuild,v 1.2 2005/03/24 06:15:45 dostrow Exp $

DESCRIPTION="Xfce 4 base ebuild"
LICENSE="GPL-2 BSD LGPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

RDEPEND="~xfce-base/xfce-mcs-plugins-4.2.1
	~xfce-base/xfce4-panel-${PV}
	~xfce-base/xfwm4-4.2.1
	~xfce-base/xfce-utils-4.2.1
	~xfce-base/xfdesktop-4.2.1
	~xfce-base/xfce4-session-4.2.1
	~xfce-base/xfprint-4.2.1
	~xfce-extra/xfce4-iconbox-4.2.1
	~xfce-extra/xfce4-systray-4.2.1
	~xfce-extra/xfce4-toys-4.2.1
	~xfce-extra/xfce4-trigger-launcher-4.2.1
	~xfce-extra/xfwm4-themes-4.2.1
	~xfce-extra/xfcalendar-4.2.1
	~xfce-extra/xfce4-appfinder-4.2.1
	~xfce-extra/xfce4-icon-theme-4.2.1
	~xfce-base/xffm-4.2.1
	~xfce-extra/xfce4-mixer-4.2.1
	!xfce-base/xfce4-base"
XFCE_META=1

inherit xfce4

pkg_postinst() {
	einfo ""
	ewarn "As of Xfce 4.2 xfce-base/xfce4-base is deprecated, please remove it."
	einfo ""
	einfo "For extra functionality please emerge xfce-base/xfce4-extras."
	einfo "To start Xfce the default script is startxfce4."
	einfo ""
}
