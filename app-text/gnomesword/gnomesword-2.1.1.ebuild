# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gnomesword/gnomesword-2.1.1.ebuild,v 1.1 2004/08/18 17:22:44 squinky86 Exp $

inherit libtool gnome2

DESCRIPTION="Gnome Bible study software"
HOMEPAGE="http://gnomesword.sf.net/"
SRC_URI="mirror://sourceforge/gnomesword/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="spell"

RDEPEND=">=gnome-extra/libgtkhtml-3.0
	>=gnome-extra/gal-1.99.11
	>=gnome-base/gnome-print-0.35
	>=media-libs/gdk-pixbuf-0.18
	>=app-text/sword-1.5.8_pre1
	>=x11-libs/gtk+-2
	spell? ( app-text/gnome-spell )
	>=gnome-base/libgnomeui-1.112.1
	>=gnome-base/libglade-1.99.9"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12
	>=dev-util/intltool-0.22"

G2CONF="${G2CONF} --enable-sword_cvs $(use_enable spell pspell)"
DOCS="COPYING NEWS ChangeLog README TODO"
