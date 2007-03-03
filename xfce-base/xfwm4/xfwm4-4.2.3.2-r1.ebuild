# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfwm4/xfwm4-4.2.3.2-r1.ebuild,v 1.6 2007/03/03 13:27:09 nixnut Exp $

inherit eutils xfce42 versionator

DESCRIPTION="Xfce4 window manager"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 ~sparc x86 ~x86-fbsd"

MY_PV=$(get_version_component_range 1-3)

RDEPEND="x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXpm
	x11-libs/startup-notification
	~xfce-base/xfce-mcs-manager-${MY_PV}"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto
	x11-libs/libXt
	sys-devel/autoconf"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-workspace.patch
}

XFCE_CONFIG="--enable-randr --enable-compositor"
core_package
