# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/mlview/mlview-0.6.3.ebuild,v 1.5 2004/10/05 12:19:43 pvdabeel Exp $

inherit eutils gnome2

DESCRIPTION="XML editor for the GNOME environment"
HOMEPAGE="http://www.freespiders.org/projects/gmlview/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

RDEPEND=">=gnome-base/libgnomeui-2.2
	>=gnome-base/libgnome-2.2
	>=gnome-base/gconf-2.2
	>=dev-libs/libxml2-2.5.11
	>=dev-libs/libxslt-1.0.33
	>=dev-libs/glib-2.2
	>=x11-libs/gtk+-2.2
	>=gnome-base/libglade-2
	>=gnome-base/eel-2.2"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.25
	dev-util/pkgconfig"

DOCS="AUTHORS BRANCHES ChangeLog NEWS README"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Patch to fix source mistakes that break compilation under gcc 2.
	epatch ${FILESDIR}/${P}-gcc2_fix.patch
}
