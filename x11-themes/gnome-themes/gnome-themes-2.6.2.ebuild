# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-themes/gnome-themes-2.6.2.ebuild,v 1.5 2004/07/31 03:08:58 spider Exp $

# FIXME : the engines in here should probably be disabled and done in seperate ebuilds

inherit gnome2

DESCRIPTION="A set of gnome2 themes, with sets for users with limited or low vision"
HOMEPAGE="http://www.gnome.org/softwaremap/projects/gnome-themes"

IUSE=""
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64 ~mips ppc64"
LICENSE="LGPL-2.1"

RDEPEND=">=x11-libs/gtk+-2
	>=x11-themes/gtk-engines-2.2.0
	!x11-themes/gtk-engines-thinice
	!x11-themes/gtk-engines-lighthouseblue
	!x11-themes/gtk-engines-crux
	!x11-themes/gtk-engines-mist"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.29
	!x11-theme/gtk-themes"

DOCS="AUTHORS COPYING README INSTALL NEWS ChangeLog"
