# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gucharmap/gucharmap-1.4.2.ebuild,v 1.9 2005/04/02 03:05:03 geoman Exp $

inherit gnome2 eutils

DESCRIPTION="Unicode character map viewer"
HOMEPAGE="http://gucharmap.sourceforge.net/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc sparc x86 ~ppc64"
IUSE="gnome cjk"

RDEPEND=">=dev-libs/glib-2.3
	>=x11-libs/pango-1.2.1
	>=x11-libs/gtk+-2.2
	dev-libs/popt
	gnome? ( >=gnome-base/libgnome-2.2
		 >=gnome-base/libgnomeui-2.2 )
	!<gnome-extra/gnome-utils-2.3"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	app-text/scrollkeeper
	>=dev-util/intltool-0.29"

G2CONF="${G2CONF} $(use_enable gnome) $(use_enable cjk unihan)"

DOCS="ChangeLog README TODO"
