# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xfce4-notifyd/xfce4-notifyd-0.1.0-r1.ebuild,v 1.1 2009/07/22 07:07:34 ssuominen Exp $

EAPI=1
inherit eutils xfce4

XFCE_VERSION=4.6

DESCRIPTION="Xfce4 notification daemon"
HOMEPAGE="http://spuriousinterrupt.org/projects/xfce4-notifyd"
SRC_URI="http://spuriousinterrupt.org/files/${PN}/${P}.tar.bz2"
KEYWORDS="~amd64 ~x86"
IUSE="debug +libsexy"

RDEPEND="dev-libs/dbus-glib
	gnome-base/libglade
	>=x11-libs/gtk+-2.10:2
	>=xfce-base/libxfce4util-${XFCE_VERSION}
	>=xfce-base/libxfcegui4-${XFCE_VERSION}
	>=xfce-base/xfconf-${XFCE_VERSION}
	libsexy? ( x11-libs/libsexy )"
DEPEND="${RDEPEND}
	dev-util/intltool
	!<x11-libs/libnotify-0.4.5
	!x11-misc/notification-daemon
	!xfce-extra/notification-daemon-xfce"

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	XFCE_CONFIG=" $(use_enable libsexy) --enable-maintainer-mode"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-send-second-arg-notification-closed.patch
}
