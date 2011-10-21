# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/notify-osd/notify-osd-0.9.32.ebuild,v 1.1 2011/10/21 19:24:29 ssuominen Exp $

EAPI=4
inherit autotools gnome2-utils savedconfig

DESCRIPTION="Canonical's on-screen-display notification agent"
HOMEPAGE="http://launchpad.net/notify-osd"
SRC_URI="http://launchpad.net/${PN}/oneiric/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="minimal"

COMMON_DEPEND=">=dev-libs/dbus-glib-0.76
	>=dev-libs/glib-2.16:2
	>=x11-libs/gtk+-3.2:3
	>=x11-libs/libnotify-0.7
	x11-libs/libwnck:3
	x11-libs/libX11
	x11-libs/pixman
	!x11-misc/notification-daemon"
RDEPEND="${COMMON_DEPEND}
	!minimal? ( x11-themes/notify-osd-icons )"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
	gnome-base/gnome-common
	x11-proto/xproto"

RESTRICT="test" # virtualx.eclass: 1 of 1: FAIL: test-modules

DOCS=( AUTHORS ChangeLog NEWS README TODO )

src_prepare() {
	sed -i -e 's:noinst_PROG:check_PROG:' tests/Makefile.am || die
	use savedconfig && restore_config src/{bubble,defaults}.c
	eautoreconf
}

src_install() {
	default
	save_config src/{bubble,defaults}.c
}

pkg_preinst() {
	gnome2_icon_savelist
	gnome2_schemas_savelist
}
pkg_postinst() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}
pkg_postrm() {
	gnome2_icon_cache_update
	gnome2_schemas_update --uninstall
}
