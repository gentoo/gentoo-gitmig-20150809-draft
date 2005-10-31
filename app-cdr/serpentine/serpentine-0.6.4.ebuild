# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/serpentine/serpentine-0.6.4.ebuild,v 1.1 2005/10/31 20:40:31 metalgod Exp $

inherit gnome2 mono

DESCRIPTION="Serpentine is an application for writing CD-Audio discs. It aims
for simplicity, usability and compability."
HOMEPAGE="http://s1x.homelinux.net/projects/serpentine"
SRC_URI="http://download.berlios.de/serpentine/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="muine"

RDEPEND=">=dev-lang/python-2.4
	>=dev-python/pygtk-2.6
	>=dev-python/gnome-python-extras-2.10.0
	>=dev-python/pyxml-0.8.4
	dev-python/gst-python
	gnome-base/gconf
	x86? ( muine? ( media-sound/muine ) )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	if use muine && use x86; then
		G2CONF="$(use_enable muine )"
	fi
}
