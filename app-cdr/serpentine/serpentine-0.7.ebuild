# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/serpentine/serpentine-0.7.ebuild,v 1.3 2006/07/22 07:50:46 dertobi123 Exp $

inherit gnome2 mono

DESCRIPTION="Serpentine is an application for writing CD-Audio discs. It aims
for simplicity, usability and compability."
HOMEPAGE="http://s1x.homelinux.net/projects/serpentine"
SRC_URI="http://download.berlios.de/serpentine/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="muine"

RDEPEND=">=dev-lang/python-2.4
	>=dev-python/pygtk-2.6
	>=dev-python/gnome-python-desktop-2.14.0
	>=dev-python/pyxml-0.8.4
	>=dev-python/gst-python-0.10
	gnome-base/gconf
	>=media-plugins/gst-plugins-gnomevfs-0.10
	muine? ( media-sound/muine )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README TODO"

G2CONF="${G2CONF} $(use_enable muine)"
