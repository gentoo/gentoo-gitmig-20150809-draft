# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/ggv/ggv-1.99.7.ebuild,v 1.1 2002/06/15 15:03:07 spider Exp $



inherit gnome2
S=${WORKDIR}/${P}
DESCRIPTION="your favourite PostScript previewer"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/ggv/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"
SLOT="1"
LICENSE="GPL-2"

DEPEND=">=x11-libs/gtk+-2.0.0
	>=x11-libs/pango-1.0.0
	>=dev-libs/glib-2.0.0
	>=gnome-base/libbonoboui-1.113.0
	>=gnome-base/libgnome-1.113.0
	>=gnome-base/ORBit2-2.3.106
	>=gnome-base/libglade-1.99.9
	app-text/ghostscript
	>=dev-libs/popt-1.6"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc )
	>=dev-util/pkgconfig-0.12.0"


G2CONF="${G2CONF} --disable-install-schemas --enable-platform-gnome-2"
DOC="AUTHORS COPYING ChangeL* INSTALL MAINTAINERS NEWS  README* TODO*"
