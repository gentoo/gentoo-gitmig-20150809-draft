# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/gcdemu/gcdemu-1.2.0.ebuild,v 1.6 2011/10/23 21:48:29 tetromino Exp $

EAPI="1"

inherit gnome2

DESCRIPTION="gCDEmu is a GNOME applet for controlling CDEmu daemon"
HOMEPAGE="http://cdemu.org/"
SRC_URI="mirror://sourceforge/cdemu/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="libnotify"

COMMON_DEPEND=">=dev-lang/python-2.4
	>=dev-python/pygtk-2.6
	>=dev-python/pygobject-2.6:2
	>=dev-python/libgnome-python-2.6
	>=dev-python/gnome-applets-python-2.6
	dev-python/gconf-python
	>=dev-python/dbus-python-0.71
	>=app-cdr/cdemud-1.0.0"
DEPEND="${COMMON_DEPEND}
	app-text/gnome-doc-utils
	dev-util/pkgconfig
	dev-util/intltool"
RDEPEND="${COMMON_DEPEND}
	libnotify? ( dev-python/notify-python )"

DOCS="AUTHORS ChangeLog README"
