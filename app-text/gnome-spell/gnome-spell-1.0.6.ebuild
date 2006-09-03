# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gnome-spell/gnome-spell-1.0.6.ebuild,v 1.10 2006/09/03 21:53:21 kumba Exp $

inherit libtool eutils gnome2

DESCRIPTION="Gnome spellchecking component"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="static"

RDEPEND=">=gnome-base/libgnomeui-1.112.1
	>=gnome-base/libbonoboui-1.112.1
	>=gnome-base/libglade-1.99.9
	>=gnome-base/libbonobo-2.0
	>=gnome-base/orbit-2
	>=x11-libs/gtk+-2.4
	>=app-text/enchant-1"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext
	>=sys-devel/autoconf-2.59"

DOCS="AUTHORS ChangeLog NEWS README"

USE_DESTDIR="1"

G2CONF="${G2CONF} $(use_enable static)"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Use enchant backend instead of aspell
	epatch ${FILESDIR}/${P}-enchant.patch
	epatch ${FILESDIR}/${P}-combo.patch

	einfo "Runnig aclocal"
	aclocal || die "aclocal failed"
	einfo "Running autoconf"
	WANT_AUTOCONF=2.5 autoconf || die "autoconf failed"
	einfo "Running automake"
	WANT_AUTOMAKE=1.9 automake || die "automake failed"
	einfo "Running libtoolize"
	libtoolize --copy --force
}
