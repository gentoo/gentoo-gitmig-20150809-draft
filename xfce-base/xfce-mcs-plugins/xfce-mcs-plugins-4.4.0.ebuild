# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce-mcs-plugins/xfce-mcs-plugins-4.4.0.ebuild,v 1.2 2007/01/22 21:12:41 welp Exp $

inherit xfce44

xfce44

DESCRIPTION="Xfce4 MCS Plugins"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

RDEPEND="x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libXext
	x11-libs/libXxf86misc
	x11-libs/libXxf86vm
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2.6
	>=xfce-base/libxfce4mcs-4.4
	>=xfce-base/libxfce4util-4.4
	>=xfce-base/libxfcegui4-4.4
	>=xfce-base/xfce-mcs-manager-4.4"
DEPEND="${RDEPEND}
	x11-proto/xf86miscproto
	x11-proto/xf86vidmodeproto
	x11-proto/xproto
	>=xfce-extra/xfce4-dev-tools-${PV}"

XFCE_CONFIG="${XFCE_CONFIG} --enable-xf86misc --enable-xkb --enable-randr --enable-xf86vm"

xfce44_core_package
