# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-themes/gnome-themes-0.2.ebuild,v 1.3 2002/12/15 10:44:24 bjb Exp $

inherit gnome2 debug

S=${WORKDIR}/${P}
DESCRIPTION="Gnome2 default themes"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
KEYWORDS="x86 ppc sparc alpha"
LICENSE="GPL-2 LGPL-2.1 FDL-1.1"

RDEPEND=""
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.22"


DOC="AUTHORS COPY* README HACKING INSTALL NEWS TODO ChangeLog"



