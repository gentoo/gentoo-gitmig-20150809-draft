# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomeprintui/libgnomeprintui-2.1.1.ebuild,v 1.1 2002/11/13 00:25:15 foser Exp $

inherit gnome2 debug

S=${WORKDIR}/${P}
DESCRIPTION="user interface libraries for gnome print"
HOMEPAGE="http://www.gnome.org/"
SLOT="2.2"
KEYWORDS="x86 ppc sparc sparc64 alpha"
LICENSE="GPL-2 LGPL-2.1"

RDEPEND="=gnome-base/libgnomeui-2.1*
	=gnome-base/libgnomeprint-2.1*
	=gnome-base/libgnomecanvas-2.1*"

DEPEND="${RDEPEND} >=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README"

