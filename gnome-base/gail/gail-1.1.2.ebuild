# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gail/gail-1.1.2.ebuild,v 1.1 2002/10/27 14:42:12 foser Exp $

inherit gnome2 debug

S=${WORKDIR}/${P}
DESCRIPTION="Part of Gnome Accessibility"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
KEYWORDS="x86 ppc sparc sparc64 alpha"
LICENSE="GPL-2"

DEPEND=">=dev-util/pkgconfig-0.12.0
	=x11-libs/gtk+-2.1*
	>=dev-libs/glib-2.0.4
	=x11-libs/pango-1.1*
	=dev-libs/atk-1.1*
	=gnome-base/libgnomecanvas-2.1*"

DOCS="AUTHORS ChangeLog COPYING README* INSTALL NEWS"

