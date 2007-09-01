# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce-mcs-plugins/xfce-mcs-plugins-4.4.1-r1.ebuild,v 1.8 2007/09/01 16:55:19 nixnut Exp $

inherit eutils xfce44

XFCE_VERSION=4.4.1
xfce44

DESCRIPTION="Setting plugins"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ~ppc64 sparc x86 ~x86-fbsd"

IUSE="debug"

RDEPEND="x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libXext
	x11-libs/libXxf86misc
	x11-libs/libXxf86vm
	>=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.6
	>=xfce-base/libxfcegui4-${XFCE_MASTER_VERSION}
	>=xfce-base/xfce-mcs-manager-${XFCE_MASTER_VERSION}
	x11-apps/xrdb"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	dev-util/intltool"

XFCE_CONFIG="${XFCE_CONFIG} --enable-xf86misc --enable-xkb --enable-randr --enable-xf86vm"

DOCS="AUTHORS ChangeLog NEWS README"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-xrdb.patch
}

xfce44_core_package
