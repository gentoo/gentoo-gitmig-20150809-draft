# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xdpyinfo/xdpyinfo-0.99.0.ebuild,v 1.5 2005/08/24 00:57:28 vapier Exp $

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular

PATCHES="${FILESDIR}/xineramaproto.patch"

DESCRIPTION="X.Org xdpyinfo application"
KEYWORDS="~arm ~s390 ~sparc ~x86"
RDEPEND="x11-libs/libXext
	x11-libs/libX11
	x11-libs/libXtst
	x11-libs/libXxf86vm
	x11-libs/libXxf86dga
	x11-libs/libXxf86misc
	x11-libs/libXi
	x11-libs/libXrender
	x11-libs/libXinerama
	x11-libs/libdmx
	x11-libs/libXp"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-proto/kbproto
	x11-proto/xf86vidmodeproto
	x11-proto/xf86dgaproto
	x11-proto/xf86miscproto
	x11-proto/inputproto
	x11-proto/renderproto
	x11-proto/xineramaproto
	x11-proto/dmxproto
	x11-proto/printproto"
