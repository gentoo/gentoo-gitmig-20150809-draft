# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-base/xfce4-base-4.1.90.ebuild,v 1.2 2004/11/05 00:19:10 vapier Exp $

DESCRIPTION="Xfce 4 base ebuild"
HOMEPAGE="http://www.xfce.org/"
SRC_URI=""

LICENSE="GPL-2 BSD LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="=xfce-base/libxfce4util-4.1.90
	=xfce-base/libxfcegui4-4.1.90
	=xfce-base/libxfce4mcs-4.1.90
	=xfce-base/xfce-mcs-manager-4.1.90
	=xfce-base/xfce-mcs-plugins-4.1.90
	=xfce-base/xfce4-panel-4.1.90
	=xfce-base/xfwm4-4.1.90
	=xfce-base/xfce-utils-4.1.90
	=xfce-base/xfdesktop-4.1.90
	=xfce-base/xfce4-session-4.1.90
	=xfce-base/xfprint-4.1.90
	=x11-themes/gtk-engines-xfce-2.2.0
	=xfce-extra/xfce4-iconbox-4.1.90
	=xfce-extra/xfce4-systray-4.1.90
	=xfce-extra/xfce4-toys-4.1.90
	=xfce-extra/xfce4-trigger-launcher-4.1.90
	=xfce-extra/xfwm4-themes-4.1.90
	=xfce-extra/xfcalendar-4.1.90
	=xfce-extra/xfce4-appfinder-4.1.90
	=xfce-extra/xfce4-icon-theme-4.1.90
	=xfce-base/xffm-4.1.90"
	#=xfce-extra/xfce4-mixer-4.1.90
DEPEND="!<xfce-base/xfce4-base-4.1.90"
