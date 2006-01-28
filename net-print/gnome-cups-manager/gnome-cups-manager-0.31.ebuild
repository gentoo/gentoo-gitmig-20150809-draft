# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/gnome-cups-manager/gnome-cups-manager-0.31.ebuild,v 1.2 2006/01/28 06:40:00 compnerd Exp $

inherit gnome2

DESCRIPTION="GNOME CUPS Printer Management Interface"
HOMEPAGE="http://www.gnome.org/"

#
# Please ensure that gcc-3.4 is stable on the arch before moving this to stable.
#

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""

# See ChangeLog regarding libgnomeui
RDEPEND=">=x11-libs/gtk+-2.3.1
	>=dev-libs/glib-2.3.1
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/libglade-2
	>=gnome-base/libbonobo-2
	>=net-print/libgnomecups-0.2.0
	gnome-base/gnome-keyring

	app-admin/gnomesu"

DEPEND=">=x11-libs/gtk+-2.3.1
	>=dev-libs/glib-2.3.1
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/libglade-2
	>=gnome-base/libbonobo-2
	>=net-print/libgnomecups-0.2.0
	gnome-base/gnome-keyring

	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.28"

DOCS="ChangeLog NEWS README"


src_install() {
	gnome2_src_install
	insinto /usr/share/applications
	doins ${FILESDIR}/${PN}.desktop
}
