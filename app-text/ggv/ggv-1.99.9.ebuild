# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/ggv/ggv-1.99.9.ebuild,v 1.1 2002/07/30 20:34:51 stroke Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="your favourite PostScript previewer"
SRC_URI="mirror://gnome/sources/ggv/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"
SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=x11-libs/gtk+-2.0.5
	>=x11-libs/pango-1.0.3
	>=dev-libs/glib-2.0.4
	>=gnome-base/libbonoboui-2.0.0
	>=gnome-base/libgnome-2.0.1
	>=gnome-base/libgnomeui-2.0.1
	>=gnome-base/ORBit2-2.4.0
	>=gnome-base/libglade-2.0.0
	app-text/ghostscript
	>=dev-libs/popt-1.6"

DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )
	>=dev-util/pkgconfig-0.12.0"


G2CONF="${G2CONF} --disable-install-schemas --enable-platform-gnome-2"
DOC="AUTHORS COPYING ChangeL* INSTALL MAINTAINERS NEWS  README* TODO*"
