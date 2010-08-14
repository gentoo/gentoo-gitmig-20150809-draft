# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gnome-spell/gnome-spell-1.0.8-r3.ebuild,v 1.5 2010/08/14 18:40:06 armin76 Exp $

inherit eutils gnome2 autotools

DESCRIPTION="Gnome spellchecking component"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="${SRC_URI}
	mirror://gentoo/${P}-isocodes-r1.patch.bz2"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="alpha amd64 ~arm ia64 ~ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=gnome-base/libbonobo-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/orbit-2
	>=x11-libs/gtk+-2.4
	>=app-text/enchant-1.2.5
	app-text/iso-codes"

DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

DOCS="AUTHORS ChangeLog NEWS README"

G2CONF="${G2CONF} --disable-static"

src_unpack() {
	gnome2_src_unpack

	# note that the combo and enchant patch are intertwined
	# the enchant patch changes libgnomeui dep to libgnome
	# made possible by the combo patch
	# Marinus Schraal <foser@gentoo.org> - 02 Apr 2006

	# Use enchant backend instead of aspell
	epatch "${FILESDIR}/${PF}-enchant.patch"

	# replace gtkentry with gtkcombo widget
	epatch "${FILESDIR}/${PN}-1.0.7-combo.patch"
	epatch "${FILESDIR}/${PN}-1.0.7-remove_gnome_h.patch"

	# Use iso-codes instead of hardcoded locales list, bug #256564
	epatch "${WORKDIR}/${P}-isocodes-r1.patch"

	# Fix test error caused by previous patch.
	echo "gnome-spell/spell-checker-language.c" >> po/POTFILES.in

	intltoolize --force || die "intltoolize failed"
	eautoreconf
}
