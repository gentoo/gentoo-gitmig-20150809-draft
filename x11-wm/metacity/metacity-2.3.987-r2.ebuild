# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-wm/metacity/metacity-2.3.987-r2.ebuild,v 1.3 2002/08/02 19:49:17 gerk Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="Small gtk2 WindowManager"
SRC_URI="http://people.redhat.com/~hp/metacity/${P}.tar.gz"
HOMEPAGE="http://people.redhat.com/~hp/metacity/"
SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

RDEPEND=">=dev-libs/glib-2.0.3
	>=x11-libs/pango-1.0.2
	>=x11-libs/gtk+-2.0.3
	>=gnome-base/gconf-1.1.11
	>=net-libs/linc-0.1.20
	>=gnome-base/ORBit2-2.4.0
	>=gnome-base/libglade-2.0.0"


DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

G2CONF="${G2CONF} --enable-platform-gnome-2"
DOCS="AUTHORS COPYING ChangeLog HACKING INSTALL NEWS README"

