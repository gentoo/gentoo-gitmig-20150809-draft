# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/assogiate/assogiate-0.2.1.ebuild,v 1.4 2011/02/24 19:22:30 tomka Exp $

inherit gnome2

DESCRIPTION="assoGiate is an editor of the file types database for GNOME"
HOMEPAGE="http://www.kdau.com/projects/assogiate"
SRC_URI="http://www.kdau.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~sparc x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.8
	>=dev-cpp/glibmm-2.8
	>=dev-cpp/gtkmm-2.8
	>=dev-cpp/libxmlpp-2.14
	>=dev-cpp/gnome-vfsmm-2.6"
DEPEND="${RDEPEND}
	app-text/gnome-doc-utils
	dev-util/pkgconfig
	dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README TODO"
