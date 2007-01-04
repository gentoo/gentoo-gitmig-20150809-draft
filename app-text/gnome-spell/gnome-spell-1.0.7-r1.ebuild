# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gnome-spell/gnome-spell-1.0.7-r1.ebuild,v 1.12 2007/01/04 14:27:55 flameeyes Exp $

WANT_AUTOMAKE="latest"
WANT_AUTOCONF="latest"

inherit eutils gnome2 autotools

DESCRIPTION="Gnome spellchecking component"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE="static"

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

pkg_setup() {

	G2CONF="${G2CONF} $(use_enable static)"

}

src_unpack() {

	unpack ${A}
	cd ${S}

	# note that the combo and enchant patch are intertwined
	# the enchant patch changes libgnomeui dep to libgnome
	# made possible by the combo patch
	# Marinus Schraal <foser@gentoo.org> - 02 Apr 2006

	# Use enchant backend instead of aspell
	epatch ${FILESDIR}/${P}-enchant-r2.patch
	# replace gtkentry with gtkcombo widget
	epatch ${FILESDIR}/${P}-combo.patch
	epatch ${FILESDIR}/${P}-remove_gnome_h.patch


	eautoreconf
}
