# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/vte/vte-0.10.17.ebuild,v 1.3 2003/02/13 17:03:30 vapier Exp $

inherit gnome2

IUSE="doc"

S=${WORKDIR}/${P}
DESCRIPTION="Xft powered terminal widget"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha"
LICENSE="LGPL-2"

RDEPEND="virtual/glibc
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=x11-libs/pango-1.1"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-0.6 )
	>=dev-util/pkgconfig-0.12.0"

DOC="AUTHORS COPY* README HACKING INSTALL NEWS TODO ChangeLog"
