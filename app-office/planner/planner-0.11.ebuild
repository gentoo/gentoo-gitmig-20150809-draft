# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/planner/planner-0.11.ebuild,v 1.4 2004/04/03 16:04:36 spider Exp $



inherit gnome2
DESCRIPTION="Project manager for Gnome2"
HOMEPAGE="http://planner.imendio.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha amd64"
IUSE="doc postgres"

RDEPEND=">=x11-libs/gtk+-2.0.5
	>=x11-libs/pango-1.0.3
	>=dev-libs/glib-2.0.4
	>=gnome-base/libgnomecanvas-2.0.1
	>=gnome-base/libglade-2.0.0
	>=gnome-base/libgnomeui-2.0.1
	>=gnome-base/gnome-vfs-2.0.2
	>=gnome-base/libgnomeprintui-2.1.9
	>=gnome-base/libbonoboui-2.0.0
	>=dev-libs/libxml2-2.4.7
	>=gnome-extra/libgsf-1.4
	app-text/scrollkeeper
	postgres? ( dev-db/postgresql )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	dev-util/intltool
	doc? ( >=dev-util/gtk-doc-0.10 )"

DOCS="AUTHORS COPYING ChangeL* INSTALL NEWS  README*"

# darn thing breaks in paralell make :/
MAKEOPTS="${MAKEOPTS} -j1"
G2CONF="${G2CONF} $(use_enable postgres)"


src_unpack () {
	unpack ${A}
	cd ${S}
	# Upstream has a newer intltool, doing this will fix some dependency problems
	intltoolize --force
}

pkg_postinst () {
	gnome2_pkg_postinst
	einfo "You will have to unmerge mrproject and libmrproject after this"
	einfo "those projects will soon dissapear, as soon as we can mark planner as stable"
	echo ""
	einfo "emerge unmerge mrproject libmrproject"
}

