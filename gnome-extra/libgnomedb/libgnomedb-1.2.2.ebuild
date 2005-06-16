# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgnomedb/libgnomedb-1.2.2.ebuild,v 1.1 2005/06/16 23:03:18 leonardop Exp $

inherit gnome2 eutils

DESCRIPTION="Database widget library."
HOMEPAGE="http://www.gnome-db.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~sparc"
IUSE="doc static"

RDEPEND=">=gnome-extra/libgda-1.1.99
	>=x11-libs/gtk+-2.4
	>=gnome-base/libglade-2
	>=gnome-base/libgnomeui-1.103
	>=gnome-base/libbonobo-2.0
	>=gnome-base/libbonoboui-2.0
	>=gnome-base/gconf-2
	>=x11-libs/gtksourceview-1"
# So far evolution-data-server support consists in a 'configure' check
#	eds? ( =gnome-extra/evolution-data-server-1.0* )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	app-text/scrollkeeper
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS"

# --disable-gnome breaks compilation, hence 'gnome' USE flag is not a good idea
G2CONF="${G2CONF} $(use_enable static)"

src_unpack() {
	unpack ${A}
	gnome2_omf_fix ${S}/doc/Makefile.in
}
