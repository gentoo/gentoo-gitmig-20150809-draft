# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/vte/vte-0.10.12.ebuild,v 1.1 2003/01/21 02:12:45 foser Exp $

inherit gnome2

IUSE="doc"

S=${WORKDIR}/${P}
DESCRIPTION="Xft powered terminal widget"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
LICENSE="GPL-2"

RDEPEND="virtual/glibc
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=x11-libs/pango-1.1"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-0.6 )
	>=dev-util/pkgconfig-0.12.0"

DOC="AUTHORS COPY* README HACKING INSTALL NEWS TODO ChangeLog"
