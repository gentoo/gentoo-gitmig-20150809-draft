# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/elementary/elementary-1.7.2.ebuild,v 1.1 2012/11/23 21:39:27 tommy Exp $

EAPI=2

inherit enlightenment

DESCRIPTION="Basic widget set, based on EFL for mobile touch-screen devices."
HOMEPAGE="http://trac.enlightenment.org/e/wiki/Elementary"
SRC_URI="http://download.enlightenment.org/releases/${P}.tar.bz2"

LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
IUSE="dbus debug examples fbcon opengl quicklaunch sdl X xcb xdg static-libs"

DEPEND="
	>=dev-libs/ecore-1.7.0[evas,fbcon?,opengl?,sdl?,X?,xcb?]
	>=media-libs/evas-1.7.0[fbcon?,opengl?,X?,xcb?]
	>=media-libs/edje-1.7.0
	dbus? ( >=dev-libs/e_dbus-1.7.0 )
	xdg? ( >=dev-libs/efreet-1.7.0 )
	"
RDEPEND="${DEPEND}"

src_configure() {
	MY_ECONF="$(use_enable dbus edbus)
		$(use_enable debug)
		$(use_enable doc)
		--disable-ecore-cocoa
		--disable-ecore-psl1ght
		--disable-ecore-wayland
		--disable-ecore-win32
		--disable-ecore-wince
		--disable-emap
		--disable-emotion
		--disable-ethumb
		--disable-eweather
		$(use_enable examples build-examples)
		$(use_enable examples install-examples)
		$(use_enable fbcon ecore-fb)
		$(use_enable sdl ecore-sdl)
		--disable-web
		$(use_enable X ecore-x)
		$(use_enable quicklaunch quick-launch)
		$(use_enable xdg efreet)"

	enlightenment_src_configure
}
