# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/notify-osd/notify-osd-0.9.30.ebuild,v 1.2 2011/03/21 22:37:03 nirbheek Exp $

EAPI=2
inherit autotools gnome2-utils

DESCRIPTION="Canonical's on-screen-display notification agent"
HOMEPAGE="http://launchpad.net/notify-osd"
SRC_URI="http://launchpad.net/${PN}/natty/natty-alpha3/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/dbus-glib-0.88
	>=dev-libs/glib-2.16:2
	gnome-base/gconf:2
	>=x11-libs/gtk+-2.22:2
	>=x11-libs/libnotify-0.4.5
	x11-libs/libwnck:1
	x11-libs/libX11
	x11-libs/pixman
	!xfce-extra/xfce4-notifyd
	!x11-misc/notification-daemon"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-proto/xproto"

RESTRICT="test" # Test suite is broken with libnotify-0.7 API

src_prepare() {
	sed -i -e '/SUBDIRS/s:tests ::' Makefile.am || die # ditto
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_preinst() {	gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
