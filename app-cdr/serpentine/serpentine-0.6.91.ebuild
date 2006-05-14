# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/serpentine/serpentine-0.6.91.ebuild,v 1.1 2006/05/14 23:42:55 metalgod Exp $

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
	>=dev-python/gnome-python-desktop-2.14.0
	>=dev-python/pyxml-0.8.4
	=dev-python/gst-python-0.8*
	gnome-base/gconf
	|| ( =media-plugins/gst-plugins-gnomevfs-0.8.10
	=media-plugins/gst-plugins-gnomevfs-0.8.11
	=media-plugins/gst-plugins-gnomevfs-0.8.12 )
	muine? ( media-sound/muine )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README TODO"

G2CONF="${G2CONF} $(use_enable muine)"
