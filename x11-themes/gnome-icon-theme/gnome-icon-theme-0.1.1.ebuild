# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-icon-theme/gnome-icon-theme-0.1.1.ebuild,v 1.1 2002/11/12 23:53:15 foser Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="Gnome2 default icon theme"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
KEYWORDS="x86 ppc sparc sparc64 alpha"
LICENSE="GPL-2 LGPL-2.1 FDL-1.1"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.22"


DOC="AUTHORS COPY* README HACKING INSTALL NEWS TODO ChangeLog"
