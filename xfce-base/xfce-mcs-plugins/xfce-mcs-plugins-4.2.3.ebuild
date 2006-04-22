# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce-mcs-plugins/xfce-mcs-plugins-4.2.3.ebuild,v 1.7 2006/04/22 10:34:55 corsair Exp $

inherit xfce42

DESCRIPTION="Xfce4 mcs plugins"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 sparc x86"

RDEPEND="|| ( ( x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXxf86misc
	x11-libs/libXxf86vm )
	virtual/x11 )
	~xfce-base/xfce-mcs-manager-${PV}"
DEPEND="${RDEPEND}
	|| ( ( x11-proto/xproto
	x11-proto/xf86miscproto
	x11-proto/xf86vidmodeproto
	x11-libs/libXt )
	virtual/x11 )"

XFCE_CONFIG="--enable-xf86misc --enable-xkb --enable-randr --enable-xf86vm"
core_package
