# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-vfs-monikers/gnome-vfs-monikers-2.15.3.ebuild,v 1.3 2006/10/03 22:58:59 agriffis Exp $

inherit virtualx gnome2

DESCRIPTION="Monikers from gnome-vfs (whatever that is)"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=gnome-base/gnome-vfs-2.15
	gnome-base/libbonobo
	>=gnome-base/gconf-2
	>=dev-libs/glib-2.9.3
	>=gnome-base/orbit-2.9"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS ChangeLog HACKING MAINTAINERS NEWS README THANKS TODO"

