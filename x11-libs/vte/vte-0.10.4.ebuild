# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/vte/vte-0.10.4.ebuild,v 1.3 2002/12/15 10:44:24 bjb Exp $

inherit gnome2 debug

IUSE="doc"

S=${WORKDIR}/${P}
DESCRIPTION="Gnome2 default icon theme"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
KEYWORDS="x86 ppc sparc alpha"
LICENSE="GPL-2 LGPL-2.1 FDL-1.1"

RDEPEND="virtual/glibc
	>=dev-libs/glib-2
	=x11-libs/pango-1.1*"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-0.6 )
	>=dev-util/pkgconfig-0.12.0"

DOC="AUTHORS COPY* README HACKING INSTALL NEWS TODO ChangeLog"



