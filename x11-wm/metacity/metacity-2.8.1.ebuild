# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/metacity/metacity-2.8.1.ebuild,v 1.6 2004/08/05 18:42:10 gmsoft Exp $

inherit gnome2

DESCRIPTION="Gnome default windowmanager"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ~ppc ~alpha ~sparc hppa amd64 ~ia64 ~mips ppc64"
IUSE="xinerama"

# not parallel-safe; see bug #14405
MAKEOPTS="${MAKEOPTS} -j1"

# sharp gtk dep is for a certain speed patch
RDEPEND="virtual/x11
	>=x11-libs/pango-1.2
	>=x11-libs/gtk+-2.2.0-r1
	>=gnome-base/gconf-2
	>=x11-libs/startup-notification-0.4"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.29"

G2CONF="${G2CONF} $(use_enable xinerama)"

DOCS="AUTHORS COPYING ChangeLog HACKING INSTALL NEWS README *txt"
