# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines/gtk-engines-2.6.10.ebuild,v 1.3 2008/03/10 22:08:12 leio Exp $

inherit gnome2

DESCRIPTION="GTK+2 standard engines and themes"
HOMEPAGE="http://www.gtk.org/"

KEYWORDS="~mips"
LICENSE="GPL-2 LGPL-2.1"
SLOT="2"
IUSE="accessibility"

RDEPEND=">=x11-libs/gtk+-2.6
	!<=x11-themes/gnome-themes-2.8.2"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	use accessibility || G2CONF="${G2CONF} --disable-hc"
}
