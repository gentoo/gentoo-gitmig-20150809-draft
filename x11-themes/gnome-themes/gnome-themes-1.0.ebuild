# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-themes/gnome-themes-1.0.ebuild,v 1.2 2003/02/13 17:37:54 vapier Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="A set of gnome2 themes, with sets for users with limited or low vision"
HOMEPAGE="http://www.gnome.org/softwaremap/projects/gnome-themes"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
LICENSE="GPL-2"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.23"

DOC="AUTHORS COPY* README INSTALL NEWS ChangeLog"
