# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4/xfce4-4.1.91.ebuild,v 1.1 2004/11/01 02:54:10 bcowan Exp $

IUSE=""
DESCRIPTION="Xfce 4 base ebuild"
SRC_URI=""
HOMEPAGE="http://xfce.org"

LICENSE="GPL-2 BSD LGPL-2"
SLOT="0"
KEYWORDS="~ia64 ~x86 ~ppc ~alpha ~sparc ~amd64 ~hppa ~mips"

RDEPEND="=xfce-base/xfce4-base-${PV}
	=xfce-base/xfce-mcs-plugins-${PV}
	=xfce-base/xfce4-panel-${PV}
	=xfce-base/xfwm4-${PV}
	=xfce-base/xfce-utils-${PV}
	=xfce-base/xfdesktop-${PV}
	=xfce-base/xfce4-session-${PV}
	=xfce-base/xfprint-${PV}
	=xfce-extra/xfce4-iconbox-${PV}
	=xfce-extra/xfce4-systray-${PV}
	=xfce-extra/xfce4-toys-${PV}
	=xfce-extra/xfce4-trigger-launcher-${PV}
	=xfce-extra/xfwm4-themes-${PV}
	=xfce-extra/xfcalendar-${PV}
	=xfce-extra/xfce4-appfinder-${PV}
	=xfce-extra/xfce4-icon-theme-${PV}
	=xfce-base/xffm-${PV}
	=xfce-extra/xfce4-mixer-${PV}"