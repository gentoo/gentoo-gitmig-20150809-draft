# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gnome-spell/gnome-spell-1.0.5-r2.ebuild,v 1.14 2004/11/04 00:10:02 geoman Exp $

inherit gnome.org gnome2 libtool eutils

DESCRIPTION="Gnome spellchecking component"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="x86 sparc ppc alpha hppa amd64 ia64 mips"
IUSE=""

RDEPEND=">=gnome-base/libgnomeui-2.2
	>=gnome-base/libbonoboui-2.0
	>=gnome-base/libglade-2.0
	>=gnome-base/libbonobo-2.0
	>=x11-libs/gtk+-2.4
	>=gnome-base/orbit-2
	>=app-text/enchant-1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	>=dev-lang/perl-5.6.0
	>=sys-devel/autoconf-2.58"

DOCS="AUTHORS ChangeLog NEWS README"

src_unpack() {

	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-enchant.patch
	epatch ${FILESDIR}/${P}-gtk24.patch
	WANT_AUTOCONF=2.5 autoconf || die "autoconf failed"
	WANT_AUTOMAKE=1.4 automake || die "automake failed"

}
