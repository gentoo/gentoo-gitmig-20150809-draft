# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gnome-spell/gnome-spell-1.0.8.ebuild,v 1.10 2010/07/20 02:02:03 jer Exp $

inherit eutils gnome2 autotools

DESCRIPTION="Gnome spellchecking component"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=gnome-base/libgnome-1.112.1
	>=gnome-base/libbonoboui-1.112.1
	>=gnome-base/libglade-1.99.9
	>=gnome-base/libbonobo-2.0
	>=gnome-base/orbit-2
	>=x11-libs/gtk+-2.4
	>=app-text/enchant-1.2.5"

DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

DOCS="AUTHORS ChangeLog NEWS README"

src_unpack() {
	gnome2_src_unpack

	# note that the combo and enchant patch are intertwined
	# the enchant patch changes libgnomeui dep to libgnome
	# made possible by the combo patch
	# Marinus Schraal <foser@gentoo.org> - 02 Apr 2006

	# Use enchant backend instead of aspell
	epatch "${FILESDIR}/${P}-enchant.patch"

	# replace gtkentry with gtkcombo widget
	epatch "${FILESDIR}/${PN}-1.0.7-combo.patch"
	epatch "${FILESDIR}/${PN}-1.0.7-remove_gnome_h.patch"

	intltoolize --force || die "intltoolize failed"
	eautoreconf
}
