# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ggv/ggv-2.8.5.ebuild,v 1.15 2010/07/20 15:14:50 jer Exp $

inherit gnome2

DESCRIPTION="The GNOME PostScript document viewer"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="debug"

RDEPEND=">=x11-libs/gtk+-2.4
	>=gnome-base/libgnomeui-2.6
	>=gnome-base/orbit-2
	>=gnome-base/libbonobo-2
	>=gnome-base/gconf-2
	app-text/ghostscript-gpl
	dev-libs/popt"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	app-text/scrollkeeper
	>=dev-util/intltool-0.30"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"
G2CONF="${G2CONF} --enable-pdf-options $(use_enable debug bonobo-debug)"
