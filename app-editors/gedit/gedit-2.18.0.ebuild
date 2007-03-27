# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gedit/gedit-2.18.0.ebuild,v 1.1 2007/03/27 20:25:59 dang Exp $

inherit gnome2

DESCRIPTION="A text editor for the GNOME desktop"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="doc spell"

RDEPEND=">=gnome-base/gconf-2
	>=dev-libs/glib-2.12
	>=x11-libs/gtk+-2.10
	>=x11-libs/gtksourceview-1.8.0
	>=gnome-base/libgnomeui-2.16
	>=gnome-base/libglade-2.5.1
	>=gnome-base/libgnomeprintui-2.12.1
	>=gnome-base/gnome-vfs-2.16
	spell? (
		>=app-text/enchant-1.2
		app-text/iso-codes
	)
	>=dev-python/pygtk-2.9.7
	>=dev-python/pygobject-2.11.5
	>=dev-python/gnome-python-desktop-2.15.90"
# FIXME: Doesn't build without python
# FIXME : spell autodetect only

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.9
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/intltool-0.35
	>=app-text/gnome-doc-utils-0.3.2"

DOCS="AUTHORS BUGS ChangeLog MAINTAINERS NEWS README THANKS TODO"

if [[ "${ARCH}" == "PPC" ]] ; then
	# HACK HACK HACK: someone fix this garbage
	MAKEOPTS="${MAKEOPTS} -j1"
fi

