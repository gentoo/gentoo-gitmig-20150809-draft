# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-themes/gnome-themes-0.3.ebuild,v 1.4 2003/02/13 17:37:49 vapier Exp $

inherit gnome2 debug

S=${WORKDIR}/${P}
DESCRIPTION="Gnome2 default themes"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
KEYWORDS="x86 ppc sparc alpha"
LICENSE="GPL-2 LGPL-2.1 FDL-1.1"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.22"


DOC="AUTHORS COPY* README HACKING INSTALL NEWS TODO ChangeLog"



