# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-terms/gnome-terminal/gnome-terminal-2.0.1.ebuild,v 1.2 2002/09/05 21:16:05 spider Exp $

inherit gnome2
S=${WORKDIR}/${P}
DESCRIPTION="The Gnome Terminal"

SRC_URI="mirror://gnome/2.0.0/sources/${PN}/${P}.tar.bz2"

HOMEPAGE="http://www.gnome.org/"
KEYWORDS="x86 ppc"
SLOT="0"
LICENSE="GPL-2"

RDEPEND=">=x11-libs/pango-1.0.4
	>=x11-libs/gtk+-2.0.6
	>=x11-libs/libzvt-2.0.0
	>=gnome-base/libglade-2.0.0-r1
	>=gnome-base/gconf-1.2.1
	>=gnome-base/libgnomeui-2.0.1
	>=app-text/scrollkeeper-0.3.9"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	!gnome-base/gnome-core"
# gnome-core overwrite /usr/bin/gnome-terminal

DOCS="ABOUT-NLS AUTHORS ChangeLog COPYING README* INSTALL NEWS TODO"

