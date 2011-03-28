# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gnome-scan/gnome-scan-0.6.2.ebuild,v 1.4 2011/03/28 22:03:24 eva Exp $

EAPI="3"

inherit gnome2

DESCRIPTION="The Gnome Scan project aim to provide scan features every where in the desktop like print is."
HOMEPAGE="http://www.gnome.org/projects/gnome-scan/index"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc"

RDEPEND=">=x11-libs/gtk+-2.12:2
	media-gfx/sane-backends
	~media-libs/gegl-0.0.22
	~media-libs/babl-0.0.22
	>=media-gfx/gimp-2.3
	>=gnome-base/libglade-2.6:2.0
	gnome-base/gconf:2"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.35
	dev-util/pkgconfig"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README THANKS TODO"
	G2CONF="${G2CONF} $(use_enable debug)"
}
