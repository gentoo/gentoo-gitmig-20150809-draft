# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/librsvg/librsvg-2.2.1.ebuild,v 1.1 2003/01/31 01:40:23 foser Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="rendering svg library"
HOMEPAGE="http://www.gnome.org/"
SLOT="2"
KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2 LGPL-2.1"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=media-libs/libart_lgpl-2.3.10
	>=dev-libs/libxml2-2.4.7
	>=x11-libs/pango-1.1"

DEPEND="${RDEPEND} 
	>=dev-util/pkgconfig-0.12.0"
	
DOCS="AUTHORS ChangeLog COPYIN* README INSTALL NEWS TODO"
