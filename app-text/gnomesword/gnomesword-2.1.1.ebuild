# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gnomesword/gnomesword-2.1.1.ebuild,v 1.2 2004/08/18 19:44:33 squinky86 Exp $

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
	>=app-text/sword-1.5.8_pre1
	>=x11-libs/gtk+-2
	spell? ( app-text/gnome-spell )
	>=gnome-base/libgnomeui-2
	>=gnome-extra/gal-1.99
	>=dev-libs/libxml-1.8"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12
	>=dev-util/intltool-0.22"

G2CONF="${G2CONF} --enable-sword_cvs $(use_enable spell pspell)"
DOCS="COPYING NEWS ChangeLog README TODO"
