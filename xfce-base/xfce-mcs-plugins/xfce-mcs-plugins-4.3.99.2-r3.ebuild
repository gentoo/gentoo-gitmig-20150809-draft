# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce-mcs-plugins/xfce-mcs-plugins-4.3.99.2-r3.ebuild,v 1.1 2006/12/10 19:58:32 nichoj Exp $

inherit gnome2 xfce44

xfce44_beta

DESCRIPTION="Xfce4 mcs plugins"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

RDEPEND="|| ( ( x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libXext
	x11-libs/libXxf86misc
	x11-libs/libXxf86vm )
	virtual/x11 )
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2.6
	~xfce-base/libxfce4mcs-${PV}
	~xfce-base/libxfce4util-${PV}
	~xfce-base/libxfcegui4-${PV}
	~xfce-base/xfce-mcs-manager-${PV}"
# need xfce4-dev-tools, since we patch automake and need regeneration
DEPEND="${RDEPEND}
	|| ( ( x11-proto/xf86miscproto
	x11-proto/xf86vidmodeproto
	x11-proto/xproto )
	virtual/x11 )
	xfce-extra/xfce4-dev-tools"

XFCE_CONFIG="--enable-xf86misc --enable-xkb --enable-randr --enable-xf86vm"

xfce44_core_package

src_unpack() {
	unpack ${A}
	cd ${S}
	# don't install xfce-filemanager.png, which collides with xfce4-session
	epatch ${FILESDIR}/${P}-icon.patch
	# regenerate stuff, but don't run configure yet
	NOCONFIGURE="true" xdt-autogen
}


pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
