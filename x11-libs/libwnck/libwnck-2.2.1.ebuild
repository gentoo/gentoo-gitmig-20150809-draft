# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libwnck/libwnck-2.2.1.ebuild,v 1.1 2003/02/06 12:49:13 foser Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="A window navigation construction kit"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

RDEPEND="virtual/glibc
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2.1"		

DEPEND=">=dev-util/pkgconfig-0.12.0 ${RDEPEND}"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"
