# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gal/gal-2.2.0.ebuild,v 1.1 2004/09/13 21:44:07 tseng Exp $

inherit gnome2 libtool debug eutils

DESCRIPTION="The Gnome Application Libraries"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="2.2"
KEYWORDS="~x86 ~ppc ~sparc ~hppa ~alpha ~ia64 ~amd64 ~mips"
IUSE="doc"

RDEPEND=">=x11-libs/gtk+-2.2
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2.1
	>=gnome-base/libglade-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnomecanvas-2
	>=dev-libs/libxml2-2
	app-text/scrollkeeper"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	>=dev-util/intltool-0.30
	doc? ( dev-util/gtk-doc )"

MAKEOPTS="${MAKEOPTS} -j1"
USE_DESTDIR="1"
ELTCONF="--reverse-deps"
G2CONF="--disable-gtk-doc"

src_unpack() {
	unpack ${A}

	gnome2_omf_fix

	cd ${S}
	#GCC 3.4 fix
	epatch ${FILESDIR}/gal-2.1.12-gcc34.patch

	#USE=doc build fix
	epatch ${FILESDIR}/gal-2.2.0-docfix.patch
	cd ${S}/docs
	for x in gal*; do mv "$x" `echo $x | sed -e 's/gal/gal-2.2/g';`; done
}
