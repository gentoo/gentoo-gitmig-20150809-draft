# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-themes/gnome-themes-2.4.1.ebuild,v 1.11 2004/11/08 19:00:14 vapier Exp $

# FIXME : the engines in here should probably be disabled and done in seperate ebuilds

inherit gnome2 eutils

DESCRIPTION="A set of gnome2 themes, with sets for users with limited or low vision"
HOMEPAGE="http://www.gnome.org/softwaremap/projects/gnome-themes"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64 mips arm"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=x11-themes/gtk-engines-2.2.0
	>=x11-themes/gtk-engines-thinice-2.0.2
	!x11-themes/gtk-engines-crux"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.23
	!x11-themes/gtk-themes"

DOCS="AUTHORS COPYING README INSTALL NEWS ChangeLog"

src_unpack() {
	unpack ${A}
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${PN}-2.4.0-nothinice.patch
}

