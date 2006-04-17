# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4/xfce4-4.2.3.2.ebuild,v 1.6 2006/04/17 18:24:52 hansmi Exp $

inherit versionator

DESCRIPTION="Xfce 4 base ebuild"
HOMEPAGE="http://www.xfce.org/"
LICENSE="GPL-2 BSD LGPL-2"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~mips ppc ~ppc64 sparc x86"
SLOT="0"
IUSE=""

MY_PV=$(get_version_component_range 1-3)

RDEPEND="~xfce-base/libxfce4util-${PV}
	~xfce-base/libxfcegui4-${MY_PV}
	~xfce-base/libxfce4mcs-${MY_PV}
	~xfce-base/xfce-mcs-manager-${MY_PV}
	~xfce-base/xfce-mcs-plugins-${MY_PV}
	~xfce-base/xfce4-panel-${MY_PV}
	~xfce-base/xfwm4-${PV}
	~xfce-base/xfce-utils-${MY_PV}
	~xfce-base/xfdesktop-${MY_PV}
	~xfce-base/xfce4-session-${MY_PV}
	~xfce-base/xfprint-${MY_PV}
	~xfce-extra/xfce4-iconbox-${MY_PV}
	~xfce-extra/xfce4-systray-${MY_PV}
	~xfce-extra/xfce4-toys-${MY_PV}
	~xfce-extra/xfce4-trigger-launcher-${MY_PV}
	~xfce-extra/xfwm4-themes-${MY_PV}
	~xfce-extra/xfcalendar-${MY_PV}
	~xfce-extra/xfce4-appfinder-${MY_PV}
	~xfce-extra/xfce4-icon-theme-${MY_PV}
	~xfce-base/xffm-${MY_PV}
	~xfce-extra/xfce4-mixer-${MY_PV}
	!xfce-base/xfce4-base"

src_install() {
	dodir /etc/X11/Sessions
	echo startxfce4 > ${D}/etc/X11/Sessions/Xfce-4
	fperms 755 /etc/X11/Sessions/Xfce-4
}

pkg_postinst() {
	einfo
	ewarn "As of Xfce 4.2 xfce-base/xfce4-base is deprecated, please remove it."
	einfo
	einfo "For extra functionality please emerge xfce-base/xfce4-extras."
	einfo "To start Xfce the default script is startxfce4."
	einfo
}
