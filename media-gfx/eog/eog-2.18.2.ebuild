# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/eog/eog-2.18.2.ebuild,v 1.8 2007/08/28 18:30:44 jer Exp $

inherit gnome2

DESCRIPTION="The Eye of GNOME image viewer"
HOMEPAGE="http://www.gnome.org/projects/eog/"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE="jpeg lcms"

RDEPEND=">=gnome-base/gnome-vfs-2.5.91
	>=gnome-base/libgnomeui-2.5.92
	>=gnome-base/libglade-2.3.6
	>=gnome-base/libgnomecanvas-2.5.92
	>=gnome-base/gconf-2.5.90
	>=media-libs/libart_lgpl-2.3.16
	>=x11-libs/gtk+-2.10
	>=gnome-base/gnome-desktop-2.10
	>=gnome-base/gnome-common-2.12.0
	>=x11-themes/gnome-icon-theme-2.17.1
	jpeg? (
		>=media-libs/libexif-0.6.12
		media-libs/jpeg )
	lcms? ( media-libs/lcms )"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.17"

DOCS="AUTHORS ChangeLog HACKING MAINTAINERS NEWS README THANKS TODO"

pkg_setup() {
	G2CONF="${G2CONF} $(use_with jpeg libjpeg) \
		$(use_with jpeg libexif) \
		$(use_with lcms cms)"
}
