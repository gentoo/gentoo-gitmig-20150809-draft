# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/zenity/zenity-2.10.1.ebuild,v 1.3 2005/08/26 00:00:49 agriffis Exp $

inherit gnome2

DESCRIPTION="commandline dialog tool for gnome"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ia64 ~mips ~ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.3.1
	>=gnome-base/libglade-2
	>=gnome-base/libgnomecanvas-2
	>=dev-libs/glib-2.5.3
	dev-libs/popt"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.29
	app-text/scrollkeeper
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog HACKING NEWS README THANKS TODO"
USE_DESTDIR="1"
