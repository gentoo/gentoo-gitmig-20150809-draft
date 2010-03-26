# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-notifyd/xfce4-notifyd-0.1.0_p20090722.ebuild,v 1.1 2010/03/26 16:27:39 ssuominen Exp $

EAPI=2
inherit autotools

DESCRIPTION="Xfce4 notification daemon"
HOMEPAGE="http://spuriousinterrupt.org/projects/xfce4-notifyd"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug nls +libsexy"

RDEPEND=">=dev-libs/dbus-glib-0.72
	>=gnome-base/libglade-2.6
	>=x11-libs/gtk+-2.10:2
	>=xfce-base/libxfce4util-4.6
	>=xfce-base/libxfcegui4-4.6
	>=xfce-base/xfconf-4.6
	xfce-base/exo
	libsexy? ( >=x11-libs/libsexy-0.1.6 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/xfce4-dev-tools
	nls? ( dev-util/intltool
		sys-devel/gettext )
	!<x11-libs/libnotify-0.4.5
	!x11-misc/notification-daemon
	!xfce-extra/notification-daemon-xfce"

src_prepare() {
	AT_M4DIR="/usr/share/xfce4/dev-tools/m4macros" eautoreconf
}

src_configure() {
	econf \
		--enable-maintainer-mode \
		--disable-dependency-tracking \
		$(use_enable nls) \
		$(use_enable libsexy) \
		$(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
