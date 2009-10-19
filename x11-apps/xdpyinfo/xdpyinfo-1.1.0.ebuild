# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xdpyinfo/xdpyinfo-1.1.0.ebuild,v 1.1 2009/10/19 19:13:51 scarabeus Exp $

inherit x-modular

DESCRIPTION="Display information utility for X"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="dga dmx xinerama xprint"

RDEPEND="
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/libXxf86misc
	x11-libs/libXxf86vm
	dga? ( x11-libs/libXxf86dga )
	dmx? ( x11-libs/libdmx )
	xinerama? ( x11-libs/libXinerama )
	xprint? ( x11-libs/libXp )
"
DEPEND="${RDEPEND}
	x11-proto/compositeproto
	x11-proto/inputproto
	x11-proto/kbproto
	x11-proto/renderproto
	x11-proto/xf86vidmodeproto
	x11-proto/xf86miscproto
	x11-proto/xextproto
	x11-proto/xproto
	dga? ( x11-proto/xf86dgaproto )
	dmx? ( x11-proto/dmxproto )
	xinerama? ( x11-proto/xineramaproto )
	xprint? ( x11-proto/printproto )
"

pkg_setup() {
	CONFIGURE_OPTIONS="--with-xf86misc
		$(use_with dga)
		$(use_with dmx)
		$(use_with xinerama)
		$(use_with xprint)
	"
}
