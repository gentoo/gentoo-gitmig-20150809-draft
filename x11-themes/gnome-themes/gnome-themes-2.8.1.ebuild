# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-themes/gnome-themes-2.8.1.ebuild,v 1.9 2005/04/02 03:32:22 geoman Exp $

# FIXME : the engines in here should probably be disabled and done in seperate ebuilds

inherit gnome2

DESCRIPTION="A set of gnome2 themes, with sets for users with limited or low vision"
HOMEPAGE="http://www.gnome.org/softwaremap/projects/gnome-themes"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ~ppc64 sparc x86"
IUSE="accessibility"

RDEPEND=">=x11-libs/gtk+-2
	>=x11-themes/gtk-engines-2.2.0
	!x11-themes/gtk-engines-thinice
	!x11-themes/gtk-engines-lighthouseblue
	!x11-themes/gtk-engines-crux
	!x11-themes/gtk-engines-mist
	!x11-themes/gtk-engines-smooth"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.29"

G2CONF="${G2CONF} $(use_enable accessibility all-themes)"
DOCS="AUTHORS README NEWS ChangeLog"
