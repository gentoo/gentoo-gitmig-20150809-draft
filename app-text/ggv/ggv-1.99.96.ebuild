# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ggv/ggv-1.99.96.ebuild,v 1.2 2003/02/13 09:36:53 vapier Exp $

IUSE="doc"

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="your favourite PostScript previewer"
HOMEPAGE="http://www.gnome.org/"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

RDEPEND=">=x11-libs/gtk+-2.0.6
	>=x11-libs/pango-1.0.4
	>=dev-libs/glib-2.0.6
	>=gnome-base/libbonoboui-2.0.3
	>=gnome-base/libgnome-2.0.4
	>=gnome-base/libgnomeui-2.0.5
	>=gnome-base/ORBit2-2.4.1
	>=gnome-base/libglade-2.0.1
	app-text/ghostscript
	>=dev-libs/popt-1.6"

DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )
	>=dev-util/pkgconfig-0.12.0"

G2CONF="${G2CONF} --disable-install-schemas --enable-platform-gnome-2"
DOC="AUTHORS COPYING ChangeL* INSTALL MAINTAINERS NEWS  README* TODO*"
