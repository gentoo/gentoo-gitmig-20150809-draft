# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/xorg-server/xorg-server-0.99.1.ebuild,v 1.1 2005/08/08 06:37:41 spyderous Exp $

# Must be before x-modular eclass is inherited
# Hack to make sure autoreconf gets run
SNAPSHOT="yes"

inherit x-modular

MESA_PN="Mesa"
MESA_PV="6.3.1.1"
MESA_P="${MESA_PN}-${MESA_PV}"

PATCHES="${FILESDIR}/xorg-composite.patch"

SRC_URI="${SRC_URI}
	glx? ( http://xorg.freedesktop.org/extras/${MESA_P}.tar.gz )"
DESCRIPTION="X.Org X servers"
KEYWORDS="~x86"
IUSE="glx dri xinerama ipv6 minimal"
RDEPEND="x11-libs/libXfont
	x11-libs/xtrans
	x11-libs/libXau
	x11-libs/libXext
	x11-libs/libX11
	x11-libs/libxkbfile
	x11-libs/libXdmcp
	x11-libs/libXmu
	x11-libs/libXrender
	x11-libs/libXi
	media-libs/freetype"
DEPEND="${RDEPEND}
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/fixesproto
	x11-proto/damageproto
	x11-proto/xextproto
	x11-proto/xproto
	x11-proto/xf86dgaproto
	x11-proto/xf86miscproto
	x11-proto/xf86rushproto
	x11-proto/xf86vidmodeproto
	x11-proto/xf86bigfontproto
	x11-proto/compositeproto
	x11-proto/recordproto
	x11-proto/resourceproto
	x11-proto/dmxproto
	xinerama? ( x11-proto/panoramixproto )
	glx? ( x11-proto/glproto )
	dri? ( x11-proto/xf86driproto
		x11-libs/libdrm )"

if use glx; then
	confopts="${confopts} --with-mesa-source=${WORKDIR}/${MESA_P}"
fi

# localstatedir is used for the log location; we need to override the default
# from ebuild.sh
# sysconfdir is used for the xorg.conf location; same applies
CONFIGURE_OPTIONS="
	$(use_enable xinerama)
	$(use_enable ipv6)
	$(use_enable !minimal dmx)
	$(use_enable !minimal xvfb)
	$(use_enable !minimal xnest)
	$(use_enable glx)
	$(use_enable dri)
	--enable-xorg
	--enable-composite
	--enable-xtrap
	--enable-xevie
	--sysconfdir=/etc/X11
	--localstatedir=/var
	${confopts}"
