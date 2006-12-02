# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4/xfce4-4.2.2-r1.ebuild,v 1.2 2006/12/02 09:37:22 dev-zero Exp $

DESCRIPTION="Xfce 4 base ebuild"
HOMEPAGE="http://www.xfce.org/"
LICENSE="GPL-2 BSD LGPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
SLOT="0"
IUSE=""

RDEPEND="~xfce-base/xfce-mcs-plugins-${PV}
	~xfce-base/xfce4-panel-${PV}
	~xfce-base/xfwm4-${PV}
	~xfce-base/xfce-utils-${PV}
	~xfce-base/xfdesktop-${PV}
	~xfce-base/xfce4-session-${PV}
	~xfce-base/xfprint-${PV}
	~xfce-extra/xfce4-iconbox-${PV}
	~xfce-extra/xfce4-systray-${PV}
	~xfce-extra/xfce4-toys-${PV}
	~xfce-extra/xfce4-trigger-launcher-${PV}
	~xfce-extra/xfwm4-themes-${PV}
	~xfce-extra/xfcalendar-${PV}
	~xfce-extra/xfce4-appfinder-${PV}
	~xfce-extra/xfce4-icon-theme-${PV}
	~xfce-base/xffm-${PV}
	~xfce-extra/xfce4-mixer-${PV}
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
