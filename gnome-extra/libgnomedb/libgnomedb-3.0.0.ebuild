# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgnomedb/libgnomedb-3.0.0.ebuild,v 1.11 2010/07/11 14:00:58 pacho Exp $

inherit gnome2

DESCRIPTION="Database widget library from the GNOME-DB project"
HOMEPAGE="http://www.gnome-db.org/"

LICENSE="GPL-2"
SLOT="3"
KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 sparc x86"

IUSE="doc"

# Dependencies here are set looking to obtain the most functionality, given that
# they are not unreasonable (e.g. gtk+'s version, gconf even if it's optional,
# etc.).
#
# There is no evolution-data-server support yet, only a check in configure.
RDEPEND=">=x11-libs/gtk+-2.10
	>=gnome-base/gconf-2
	=gnome-extra/libgda-3*
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/libglade-2
	=x11-libs/gtksourceview-1*"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.28
	app-text/scrollkeeper
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README"

src_unpack() {
	gnome2_src_unpack

	# Fix tests
	echo "[encoding: UTF-8]" >> po/POTFILES.in
	echo "libgnomedb/data-entries/gnome-db-entry-string-number.xml.in" >> po/POTFILES.in
	echo "libgnomedb/data-entries/gnome-db-entry-string-string.xml.in" >> po/POTFILES.in
	echo "libgnomedb/data-entries/gnome-db-format-entry.c" >> po/POTFILES.in
	echo "libgnomedb/plugins/gnome-db-data-cell-renderer-password.c" >> po/POTFILES.in
	echo "libgnomedb/plugins/gnome-db-entry-password.xml.in" >> po/POTFILES.in
}
