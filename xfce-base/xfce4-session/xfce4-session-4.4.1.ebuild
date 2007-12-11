# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-session/xfce4-session-4.4.1.ebuild,v 1.10 2007/12/11 11:26:22 angelos Exp $

inherit xfce44

XFCE_VERSION="4.4.1"
xfce44

DESCRIPTION="Session manager"
HOMEPAGE="http://www.xfce.org/projects/xfce4-session/"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="dbus debug gnome"

RDEPEND="x11-libs/libX11
	x11-libs/libSM
	x11-apps/iceauth
	>=xfce-base/libxfce4util-${XFCE_MASTER_VERSION}
	>=xfce-base/libxfce4mcs-${XFCE_MASTER_VERSION}
	>=xfce-base/libxfcegui4-${XFCE_MASTER_VERSION}
	>=xfce-base/xfce-mcs-manager-${XFCE_MASTER_VERSION}
	>=xfce-base/xfce-utils-${XFCE_MASTER_VERSION}
	games-misc/fortune-mod
	gnome? ( gnome-base/gconf )
	dbus? ( sys-apps/dbus )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

XFCE_CONFIG="${XFCE_CONFIG} $(use_enable gnome) $(use_enable dbus)"

DOCS="AUTHORS BUGS ChangeLog NEWS README TODO"

xfce44_core_package
