# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/planner/planner-0.12.1.ebuild,v 1.8 2005/04/01 22:12:22 pylon Exp $

inherit gnome2 fdo-mime

DESCRIPTION="Project manager for Gnome2"
HOMEPAGE="http://planner.imendio.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha amd64"
IUSE="doc libgda python"

RDEPEND=">=x11-libs/gtk+-2.0.5
	>=x11-libs/pango-1.0.3
	>=dev-libs/glib-2.0.4
	>=gnome-base/libgnomecanvas-2.0.1
	>=gnome-base/libglade-2.0.0
	>=gnome-base/libgnomeui-2.0.1
	>=gnome-base/gnome-vfs-2.0.2
	>=gnome-base/libgnomeprintui-2.1.9
	>=gnome-base/libbonoboui-2.0.0
	>=dev-libs/libxml2-2.5.4
	>=gnome-extra/libgsf-1.4
	app-text/scrollkeeper
	libgda? ( >=gnome-extra/libgda-1.0 )
	python? ( >=dev-python/pygtk-2.0.0-r1 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	dev-util/intltool
	doc?( >=dev-util/gtk-doc-0.10 )"

DOCS="AUTHORS COPYING ChangeLog INSTALL README"

# darn thing breaks in paralell make :/
MAKEOPTS="${MAKEOPTS} -j1"
G2CONF="${G2CONF} $(use_enable libgda database) $(use_enable python) --disable-dotnet"

src_install() {

	gnome2_src_install

	# ugly fix for #83947 - FIXME : write some config magic
	rm -fr ${D}/usr/share/mime/{XMLnamespaces,globs,magic}

}

pkg_postinst () {

	gnome2_pkg_postinst
	einfo "You will have to unmerge mrproject and libmrproject after this"
	einfo "those projects will soon dissapear, as soon as we can mark planner as stable"
	echo ""
	einfo "emerge unmerge mrproject libmrproject"

}
