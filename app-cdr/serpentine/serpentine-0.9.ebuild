# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/serpentine/serpentine-0.9.ebuild,v 1.2 2008/06/04 18:56:14 drac Exp $

inherit gnome2 mono

DESCRIPTION="Serpentine is an application for writing CD-Audio discs. It aims
for simplicity, usability and compability."
HOMEPAGE="http://irrepupavel.com/projects/serpentine/"
SRC_URI="mirror://berlios/serpentine/${P}.tar.bz2"

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

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	G2CONF="${G2CONF} $(use_enable muine)"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	echo serpentine/gtkutil.py >> po/POTFILES.skip
	echo serpentine/plugins/plugsuspend.py >> po/POTFILES.skip
}
