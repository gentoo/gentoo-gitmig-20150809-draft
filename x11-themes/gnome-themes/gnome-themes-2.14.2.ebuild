# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-themes/gnome-themes-2.14.2.ebuild,v 1.10 2006/10/20 20:49:27 kloeri Exp $

inherit gnome2

DESCRIPTION="A set of GNOME themes, with sets for users with limited or low vision"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86"
IUSE="accessibility"

RDEPEND=">=x11-libs/gtk+-2
	>=x11-themes/gtk-engines-2.5"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.28"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable accessibility all-themes)"
}
