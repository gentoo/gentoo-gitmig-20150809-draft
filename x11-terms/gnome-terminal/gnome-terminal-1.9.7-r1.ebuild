# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-terms/gnome-terminal/gnome-terminal-1.9.7-r1.ebuild,v 1.1 2002/06/11 17:49:09 spider Exp $


inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="The Gnome Terminal"

SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2
         ftp://archive.progeny.com/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"

HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2"

RDEPEND=">=x11-libs/pango-1.0.0
	>=x11-libs/gtk+-2.0.0
	>=x11-libs/libzvt-1.116.1
	>=gnome-base/libglade-2.0.0
	>=gnome-base/gconf-1.1.11
	>=gnome-base/libgnomeui-1.112.1
	>=app-text/scrollkeeper-0.3.9"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"
DOCS="ABOUT-NLS AUTHORS ChangeLog COPYING README* INSTALL NEWS TODO"

SCHEMAS="gnome-terminal.schemas"

