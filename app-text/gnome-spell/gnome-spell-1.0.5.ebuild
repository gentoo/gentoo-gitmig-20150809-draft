# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gnome-spell/gnome-spell-1.0.5.ebuild,v 1.14 2004/09/27 18:30:23 pvdabeel Exp $

IUSE=""

inherit gnome.org gnome2 libtool debug # because this an unstable package

DESCRIPTION="Gnome spellchecking component."
HOMEPAGE="http://www.gnome.org/"

KEYWORDS="x86 sparc ppc alpha hppa"
SLOT="1"
LICENSE="GPL-2"

RDEPEND=">=gnome-base/libgnomeui-2.2
	>=gnome-base/libbonoboui-2.0
	>=gnome-base/libglade-2.0
	>=gnome-base/libbonobo-2.0
	>=gnome-base/orbit-2.0
	virtual/aspell-dict"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	>=dev-lang/perl-5.6.0"

# the control-center capplet seems to be missing
# so gnome-base/control-center-2.0 dep removed

src_unpack(){
	unpack ${A}

	cd ${S}/gnome-spell
	sed -e 's:-DGTK_DISABLE_DEPRECATED=1: :g' -i Makefile.in
	sed -e 's:-DGTK_DISABLE_DEPRECATED=1: :g' -i Makefile.am
}

DOCS="AUTHORS COPYING ChangeLog NEWS README"
SCROLLKEEPER_UPDATE="0"
