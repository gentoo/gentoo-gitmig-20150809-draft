# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/gnome-terminal/gnome-terminal-2.2.0.ebuild,v 1.4 2003/05/29 23:36:05 lu_zero Exp $

inherit gnome2 eutils

S=${WORKDIR}/${P}
DESCRIPTION="The Gnome Terminal"

HOMEPAGE="http://www.gnome.org/"
KEYWORDS="x86 ppc"
SLOT="0"
LICENSE="GPL-2"

RDEPEND=">=x11-libs/gtk+-2.2
	>=gnome-base/libglade-2
	>=gnome-base/gconf-1.2
	>=gnome-base/libgnomeui-2
	>=x11-libs/startup-notification-0.4
	>=x11-libs/vte-0.10.4"

# 2.1.x+ needs cvs version
#	x11-libs/libzvt"

DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/pkgconfig-0.12.0
	!gnome-base/gnome-core"
# gnome-core overwrite /usr/bin/gnome-terminal

G2CONF="${G2CONF} --with-widget=vte"

DOCS="AUTHORS ChangeLog COPYING README INSTALL NEWS TODO"
