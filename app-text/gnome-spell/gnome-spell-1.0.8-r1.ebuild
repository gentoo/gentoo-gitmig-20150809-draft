# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gnome-spell/gnome-spell-1.0.8-r1.ebuild,v 1.1 2009/02/09 22:06:49 eva Exp $

inherit eutils gnome2 autotools

DESCRIPTION="Gnome spellchecking component"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="${SRC_URI}
	mirror://gentoo/${P}-isocodes.patch.bz2"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=gnome-base/libgnome-1.112.1
	>=gnome-base/libbonoboui-1.112.1
	>=gnome-base/libglade-1.99.9
	>=gnome-base/libbonobo-2.0
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
	epatch "${FILESDIR}/${P}-enchant.patch"

	# replace gtkentry with gtkcombo widget
	epatch "${FILESDIR}/${PN}-1.0.7-combo.patch"
	epatch "${FILESDIR}/${PN}-1.0.7-remove_gnome_h.patch"

	# Use iso-codes instead of hardcoded locales list, bug #256564
	epatch "${WORKDIR}/${P}-isocodes.patch"

	# Fix test error caused by previous patch.
	echo "gnome-spell/spell-checker-language.c" >> po/POTFILES.in

	intltoolize --force || die "intltoolize failed"
	eautoreconf
}
