# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-network/gnome-network-1.99.5.ebuild,v 1.1 2004/01/16 21:38:25 foser Exp $

inherit gnome2 debug

DESCRIPTION="Collection of network tools"
HOMEPAGE="http://www.gnome.org/projects/gnome-network/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

# FIXME : probably missing runtime deps for gathering network statistics

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=gnome-base/gconf-1.2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.11
	dev-util/pkgconfig"

G2CONF="${G2CONF} --enable-debug"
