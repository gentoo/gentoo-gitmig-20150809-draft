# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/mlview/mlview-0.8.ebuild,v 1.2 2005/08/07 10:40:26 leonardop Exp $

inherit eutils gnome2

DESCRIPTION="XML editor for the GNOME environment"
HOMEPAGE="http://www.freespiders.org/projects/gmlview/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE="dbus debug static"

RDEPEND=">=dev-libs/libxml2-2.6.11
	>=dev-libs/libxslt-1.1.8
	>=dev-libs/glib-2.4.6
	>=x11-libs/gtk+-2.4.3
	>=gnome-base/libglade-2.4
	>=gnome-base/libgnome-2.6.1
	>=gnome-base/gconf-2.6.2
	>=gnome-base/eel-2.6.2
	>=x11-libs/gtksourceview-1
	dbus? ( >=sys-apps/dbus-0.22 )
	sys-libs/zlib"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.33
	dev-util/pkgconfig"

DOCS="ABOUT-NLS AUTHORS BRANCHES ChangeLog COPYRIGHT NEWS README"

G2CONF="${G2CONF} $(use_enable debug) $(use_enable static) \
$(use_enable dbus)"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Small corrections for mlview.desktop
	epatch ${FILESDIR}/${P}-dot_desktop.patch
}
